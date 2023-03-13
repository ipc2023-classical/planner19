/*******************************************************************************
 * Copyright (c) 2012 Tomas Balyo and Vojtech Bardiovsky
 * 
 * This file is part of freeLunch
 * 
 * freeLunch is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published 
 * by the Free Software Foundation, either version 3 of the License, 
 * or (at your option) any later version.
 * 
 * freeLunch is distributed in the hope that it will be useful, but 
 * WITHOUT ANY WARRANTY; without even the implied warranty 
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
 * See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with freeLunch.  If not, see <http://www.gnu.org/licenses/>.
 ******************************************************************************/

package freelunch.tutorials.sokoban;

import freelunch.benchmarks.sokoban.Sokoban;
import freelunch.benchmarks.sokoban.Sokoban.Point;
import freelunch.benchmarks.sokoban.Sokoban.Tile;
import freelunch.benchmarks.sokoban.SokobanGenerator;
import freelunch.core.planning.NonexistentPlanException;
import freelunch.core.planning.TimeoutException;
import freelunch.core.planning.model.Condition;
import freelunch.core.planning.model.SasAction;
import freelunch.core.planning.model.SasParallelPlan;
import freelunch.core.planning.model.SasProblem;
import freelunch.core.planning.model.StateVariable;
import freelunch.core.planning.model.StringActionInfo;
import freelunch.core.planning.sase.optimizer.PlanVerifier;
import freelunch.core.planning.sase.sasToSat.SasProblemBuilder;
import freelunch.core.planning.sase.sasToSat.incremental.IncrementalSolver;

/**
 * The sokoban puzzle with multiple sokobans working in parallel
 * 
 * @author Tomas Balyo Sep 30, 2012
 */
public class MultiSokobanTutorial {

    final static int DOM_FLOOR = 0;
    final static int DOM_WALL = 1;

    final static int DOM_NO = 0;
    final static int DOM_YES = 1;

    final Sokoban sokoban;
    final int height;
    final int width;
    final int boardSize;

    public MultiSokobanTutorial(Sokoban sokoban) {
        this.sokoban = sokoban;
        this.height = sokoban.game.length;
        this.width = sokoban.game[0].length;
        this.boardSize = height * width;
    }

    public static void main(String[] args) {
        MultiSokobanTutorial sokobanTutorial = new MultiSokobanTutorial(SokobanGenerator.SOKOBAN_SMALL_TEST_2_MULTI);
        sokobanTutorial.runSokobanTutorial();
    }

    public void runSokobanTutorial() {
        // We generate the planning problem (see below)
        SasProblemBuilder problem = generateProblem();
        SasProblem sasProb = problem.getSasProblem();


        // We initialize the planner with the problem
        IncrementalSolver planner = new IncrementalSolver(sasProb);

        // We solve the problem
        try {
            SasParallelPlan plan = planner.solve();

            // print the plan
            System.out.println(plan);

            // Optionally we can verify the plan
            boolean valid = PlanVerifier.verifyPlan(sasProb, plan);
            if (valid) {
                System.out.println("Plan is VALID");
            } else {
                System.out.println("Plan in INVALID");
            }

        } catch (TimeoutException e) {
            System.out.println("Timeout occured");
        } catch (NonexistentPlanException e) {
            System.out.println("The planning problem has no solution");
        }
    }

    /**
     * Generate a planning problem from an instance of {@link Sokoban} game.
     * 
     * @return the planning problem
     */
    private SasProblemBuilder generateProblem() {

        // Initialize the planning problem
        SasProblemBuilder problem = new SasProblemBuilder();

        // ==========================
        // Create the state variables
        // ==========================

        // State variables of sokoban locations
        StateVariable[] playerLocations = new StateVariable[sokoban.players.length];
        for (int i = 0; i < sokoban.players.length; i++) {
            playerLocations[i] = problem.newVariable("Sokoban" + i, boardSize);
        }

        // State variables of tiles
        StateVariable tiles[] = new StateVariable[boardSize];
        for (int i = 0; i < boardSize; i++) {
            tiles[i] = problem.newVariable("tile" + i, 2);
        }

        // State variables defining whether a tile contains a package
        StateVariable tileHasPackage[] = new StateVariable[boardSize];
        for (int i = 0; i < boardSize; i++) {
            tileHasPackage[i] = problem.newVariable("hasPackage" + i, 2);
        }

        // ==============================
        // Define the actions (operators)
        // ==============================

        for (int sok = 0; sok < sokoban.players.length; sok++) {
            for (int i = 0; i < boardSize; i++) {
                addMoveAction(problem, playerLocations[sok], tileHasPackage, i);
                addMovePackageAction(problem, playerLocations[sok], tiles, tileHasPackage, i);
            }
        }

        // ================================
        // Define the initial state
        // ================================

        // player location
        for (int sok = 0; sok < sokoban.players.length; sok++) {
            problem.addInitialStateCondition(new Condition(playerLocations[sok], toLinear(sokoban.players[sok])));
        }

        // packages and goals locations
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                switch (sokoban.game[i][j]) {
                case FLOOR:
                case GOAL:
                case PACKAGE_ON_GOAL:
                case SOKOBAN_ON_GOAL:
                    problem.addInitialStateCondition(new Condition(tiles[toLinear(new Point(i, j))], DOM_FLOOR));
                    break;
                case WALL:
                    problem.addInitialStateCondition(new Condition(tiles[toLinear(new Point(i, j))], DOM_WALL));
                    break;
                default:
                    break;
                }
                if (sokoban.game[i][j] == Tile.PACKAGE || sokoban.game[i][j] == Tile.PACKAGE_ON_GOAL) {
                    problem.addInitialStateCondition(new Condition(tileHasPackage[toLinear(new Point(i, j))], DOM_YES));
                } else {
                    problem.addInitialStateCondition(new Condition(tileHasPackage[toLinear(new Point(i, j))], DOM_NO));
                }
            }
        }

        // =================================
        // Define the goal state
        // =================================

        // we only care about the final locations of packages. All tiles that are goals must contain a package.
        for (Point point : sokoban.goals) {
            problem.addGoalCondition(new Condition(tileHasPackage[toLinear(point)], DOM_YES));
        }
        for (Point point : sokoban.floorTiles) {
            problem.addGoalCondition(new Condition(tileHasPackage[toLinear(point)], DOM_NO));
        }

        return problem;
    }

    // Create action when the player is on the location (x, y) and moves in any possible direction.
    private void addMoveAction(SasProblemBuilder problem, StateVariable playerLocation, StateVariable[] tileHasPackage, int from) {
        if (sokoban.game[toPoint(from).x][toPoint(from).y] == Tile.WALL) {
            return;
        }
        for (int direction = 0; direction < 4; direction++) {
            int to = step(direction, from);
            if (to != -1 && sokoban.game[toPoint(to).x][toPoint(to).y] != Tile.WALL) {
                SasAction op = problem.newAction(new StringActionInfo(String.format("%s Move-%s:%s->%s", playerLocation.getName(), directions[direction], toPoint(from), toPoint(to))));

                op.getPreconditions().add(new Condition(playerLocation, from));
                op.getPreconditions().add(new Condition(tileHasPackage[to], DOM_NO));

                op.getEffects().add(new Condition(playerLocation, to));
            }
        }
    }

    private void addMovePackageAction(SasProblemBuilder problem, StateVariable playerLocation, StateVariable[] tiles, StateVariable[] tileHasPackage, int from) {
        if (sokoban.game[toPoint(from).x][toPoint(from).y] == Tile.WALL) {
            return;
        }
        for (int direction = 0; direction < 4; direction++) {
            // player is on the "from" tile
            // box is on the "box" tile
            // box is moved onto the "to" tile
            int box = step(direction, from);
            int to = step(direction, box);
            if (to != -1 && box != -1 && sokoban.game[toPoint(box).x][toPoint(box).y] != Tile.WALL && sokoban.game[toPoint(to).x][toPoint(to).y] != Tile.WALL) {
                SasAction op = problem.newAction(new StringActionInfo(String.format("%s MovePackage-%s:%s->%s", playerLocation.getName(), directions[direction], toPoint(box), toPoint(to))));

                op.getPreconditions().add(new Condition(playerLocation, from));
                op.getPreconditions().add(new Condition(tileHasPackage[box], DOM_YES));
                op.getPreconditions().add(new Condition(tileHasPackage[to], DOM_NO));

                op.getEffects().add(new Condition(playerLocation, box));
                op.getEffects().add(new Condition(tileHasPackage[box], DOM_NO));
                op.getEffects().add(new Condition(tileHasPackage[to], DOM_YES));
            }
        }
    }

    /**
     * @return linearized version of a 2D coordinate.
     */
    private int toLinear(Point point) {
        return point.x * width + point.y;
    }

    /**
     * @return 2D version of a linearized coordinate.
     */
    private Point toPoint(int a) {
        return new Point(a / width, a % width);
    }

    /**
     * Creates a new linearized coordinate in a given direction.
     * 
     * @return new coordinate after applying one step, or -1 if step is not
     * valid.
     */
    private int step(int direction, int from) {
        Point point = toPoint(from);
        Point newPoint = new Point(point.x + steps[direction][0], point.y + steps[direction][1]);
        return (newPoint.x >= 0 && newPoint.x < height && newPoint.y >= 0 && newPoint.y < width) ? toLinear(newPoint) : -1;
    }

    private final int[][] steps = new int[][] { new int[] { 1, 0 }, new int[] { -1, 0 }, new int[] { 0, 1 }, new int[] { 0, -1 } };
    private final String[] directions = new String[] { "DOWN", "UP", "RIGHT", "LEFT" };

}