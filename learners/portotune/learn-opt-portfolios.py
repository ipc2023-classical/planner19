#! /usr/bin/env python

from pathlib import Path

from lab.experiment import Experiment

import project
from portfolio import Track
from ranitsearch import RanitSearchPortfolio
from selector import SelectorPortfolio, UniformPortfolio

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

TRACK = Track.OPT
SUFFIX = "opt"
DATA = "../../experiments/data/01-opt-planners-eval/properties-hardest.json.xz"

exp = Experiment()
exp.add_step(
    "remove-combined-properties", project.remove_properties, Path(exp.eval_dir)
)


exp.add_fetcher(src=DATA)

project.add_absolute_report(
    exp, attributes=ATTRIBUTES, filter=[], name=f"{exp.name}-full"
)

exp.add_report(UniformPortfolio(track=TRACK), name=f"uniform-{SUFFIX}")
exp.add_report(SelectorPortfolio(track=TRACK, subset_size="auto"), name=f"selector-{SUFFIX}")

# TODO: run this n times and choose portfolio with highest score.
exp.add_report(
    RanitSearchPortfolio(track=TRACK), name=f"randomized-iterated-search-{SUFFIX}"
)

exp.run_steps()
