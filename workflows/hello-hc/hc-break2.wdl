## This workflow is intentionally broken!

version 1.0 

workflow HelloHaplotypeCaller {

	call HaplotypeCallerGVCF
}

task HaplotypeCallerGVCF {

	input {
		String docker_image
		String java_opt
	
		File ref_fasta
		File ref_index
		File ref_dict
		File input_bam
		File input_bam_index
		File intervals
	}

	String gvcf_name = basename(input_bam, ".bam") + ".g.vcf"

	# The tool name in this command is wrong 
	# (HaploCaller instead of HaplotypeCaller)
	command {
		gatk --java-options ${java_opt} HaploCaller \
			-R ${ref_fasta} \
			-I ${input_bam} \
			-O ${gvcf_name} \
			-L ${intervals} \
			-ERC GVCF
	}
	
	output {
		File output_gvcf = "${gvcf_name}"
	}

	runtime {
		docker: docker_image
	}

}
