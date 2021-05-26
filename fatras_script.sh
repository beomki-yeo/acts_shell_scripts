#!/bin/bash

nEvents=10
pdg=211 # pion
nParticles=(10 100 500 1000 5000 10000)

for n in "${nParticles[@]}"
do
    sub_dir=${pdg}_${n}
    
    command_particle_gun="
    ${ACTS_INSTALL}/bin/ActsExampleParticleGun 
    --events=${nEvents} 
    --output-dir=${ACTS_DATA}/data/gen/${sub_dir}
    --output-csv 
    --gen-eta=-4:4 
    --gen-mom-gev=0.4:50 
    --gen-pdg=${pdg} 
    --gen-randomize-charge 
    --gen-nparticles=${n}"
    ${command_particle_gun}

    command_fatras="
    ${ACTS_INSTALL}/bin/ActsExampleFatrasGeneric 
    --input-dir=${ACTS_DATA}/data/gen/${sub_dir} \
    --output-dir=${ACTS_DATA}/data/sim_generic/${sub_dir}  \
    --output-csv  \
    --select-eta=-2.5:2.5 \
    --select-pt-gev=0.4: \
    --fatras-pmin-gev 0.4 \
    --remove-neutral \
    --bf-constant-tesla=0:0:2
    "
    ${command_fatras}
done
