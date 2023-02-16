#! /bin/bash

set -euo pipefail

TMPDIR="/tmp/apptainer-rundir"

RECIPE=$(realpath ${1})
IMAGE=$(realpath ${2})
BENCHMARKS_DIR=${DOWNWARD_BENCHMARKS}

printf "\n\n**********************************************************************\n\n\n"
echo "Recipe: ${RECIPE}"
if [[ -e ${IMAGE} ]]; then
    echo "Image ${IMAGE} exists -> will test it now."
else
    echo "Image ${IMAGE} does not exist -> will create and test it now."
    pushd $(dirname ${RECIPE})
    apptainer build ${IMAGE} ${RECIPE}
    popd
fi

echo "Testing image at ${IMAGE}:"
rm -rf ${TMPDIR}
mkdir ${TMPDIR}
cp ${BENCHMARKS_DIR}/miconic/domain.pddl ${TMPDIR}/domain.pddl
cp ${BENCHMARKS_DIR}/miconic/s1-0.pddl ${TMPDIR}/problem.pddl
DOMAIN="${TMPDIR}/domain.pddl"
PROBLEM="${TMPDIR}/problem.pddl"
PLANFILE="${TMPDIR}/my_sas_plan"

# Scorpion uses 200s of preprocessing time.
if [[ ${IMAGE} != *"scorpion.img"* ]]; then
    ulimit -St 1800
    apptainer run -C -H ${TMPDIR} ${IMAGE} ${DOMAIN} ${PROBLEM} ${PLANFILE}

    if [[ -e ${PLANFILE} ]]; then
        echo "Plan found."
    else
        echo "No plan found."
        exit 1
    fi
fi