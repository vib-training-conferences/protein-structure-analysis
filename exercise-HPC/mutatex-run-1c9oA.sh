#!/bin/bash
#SBATCH --job-name="mutatex-run-mdl-1c9oA"
#SBATCH --ntasks="1"
#SBATCH --cpus-per-task="16"
#SBATCH --time="1:30:00"
#SBATCH --mail-type="ALL"
#SBATCH --mail-user="alexander.botzki@vib.be"

# eventually load other modules
#module purge
#module load Package1 Package2 Package3

# go to the (current) working directory (optional, if this is the
# directory where you submitted the job)

echo Start Job
date

APPTAINER_CACHEDIR=/tmp/ \
APPTAINER_TMPDIR=/tmp/ \
apptainer exec $VSC_SCRATCH_PROJECTS_BASE/2026_400/20261125-Exploring-protein-structures/alexb/mutatex-v1.sif /opt/conda/envs/mutatex/bin/mutatex 1c9oA.pdb \
        -v \
        -p 16 \
        -m mutation_list.txt \
        -x $VSC_SCRATCH_PROJECTS_BASE/2026_400/20261125-Exploring-protein-structures/alexb/foldx_20270131 \
        -f suite5 \
        -R repair_runfile_template.txt \
        -M mutate_runfile_template.txt \
        -C deep \
        --foldx-log &> log-1c9oA.log

date
echo End Job
