#!/bin/bash
#SBATCH --job-name=mutatex-run-mdl-1jxx1A
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=1:00:00
#SBATCH --output=run1.stdout
#SBATCH --error=run1.stderr

# eventually load other modules
#module purge
#module load Package1 Package2 Package3

# go to the (current) working directory (optional, if this is the
# directory where you submitted the job)

echo Start Job
date

APPTAINER_CACHEDIR=/tmp/ \
APPTAINER_TMPDIR=/tmp/ \
apptainer exec /$VSC_SCRATCH_PROJECTS_BASE/2026_400/20261125-Exploring-protein-structures/alexb/mutatex-v1.sif /opt/conda/envs/mutatex/bin/mutatex model_on_1jxx1A.pdb \
        -v \
        -p 4 \
        -m mutation_list.txt \
        -x $VSC_SCRATCH_PROJECTS_BASE/2026_400/20261125-Exploring-protein-structures/alexb/foldx_20270131 \
        -f suite5 \
        -R repair_runfile_template.txt \
        -M mutate_runfile_template.txt \
        -C deep \
        --foldx-log &> log.log

date
echo End Job
