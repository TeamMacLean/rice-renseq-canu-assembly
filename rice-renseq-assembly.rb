
task :assembly do
  sh "source canu-1.6; for n in rice_pacbio_{5..9} rice_pacbio_{10..14}; do
    mkdir -p $(pwd)/${n} ;
    echo '#!/bin/bash' > $(pwd)/${n}/assembly.sh;
    echo 'source canu-1.6' >> $(pwd)/${n}/assembly.sh;
    echo canu -p assembly -d $(pwd)/${n} genomesize=430m minOverlapLength=500 minOverlapLength=100 useGrid=true gridOptions=\\\"--cpus-per-task=4 --mem-per-cpu=30G\\\" rawErrorRate=0.6 correctedErrorRate=0.105 -pacbio-raw  /tsl/data/reads/jjones/rice_renseq/${n}/*/raw/*.fastq.gz >> $(pwd)/${n}/assembly.sh;
    sbatch --mem 20G -J $n -o $(pwd)/${n}.log $(pwd)/${n}/assembly.sh;
    done"
end

task :default => [:assembly]
