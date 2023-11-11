#! /usr/bin/env python

from pathlib import Path

from lab.experiment import Experiment

import project

from portfolio import Track
from ranitsearch import RanitSearchPortfolio


DIR = Path(__file__).resolve().parent
REPO = project.get_repo_base()
BENCHMARKS_DIR = REPO / "benchmarks"
assert BENCHMARKS_DIR.exists(), BENCHMARKS_DIR
ATTRIBUTES = [
    "error",
    "coverage",
    "cost",
    "plan_length",
    "run_dir",
    "used_memory",
    "cpu_time",
]

TRACK=Track.OPT
DATA = "../../experiments/data/01-opt-planners-eval/properties-hardest.json.xz"

exp = Experiment()
exp.add_step("remove-combined-properties", project.remove_properties, Path(exp.eval_dir))


exp.add_fetcher(src=DATA)

project.add_absolute_report(exp, attributes=ATTRIBUTES, filter=[], name=f"{exp.name}-full")

# TODO: run this n times and choose portfolio with highest score.
exp.add_report(RanitSearchPortfolio(track=TRACK), name=f"randomized-iterated-search-opt")

exp.run_steps()
