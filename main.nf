#!/usr/bin/env nextflow
nextflow.enable.dsl=2

def helpMessage() {
    // TODO
    log.info """
    Please see here for usage information: https://github.com/cynapse-ccri/md5_chk/blob/main/docs/Usage.md
    """.stripIndent()
}

// Show help message
if (params.help) {
  helpMessage()
  exit 0
}

/*--------------------------------------------------------
  Defining and showing header with all params information
----------------------------------------------------------*/

// Header log info

def summary = [:]

if (workflow.revision) summary['Pipeline Release'] = workflow.revision

summary['Output dir']                                  = params.outdir
summary['Launch dir']                                  = workflow.launchDir
summary['Working dir']                                 = workflow.workDir
summary['Script dir']                                  = workflow.projectDir
summary['User']                                        = workflow.userName

// then arguments ******* EDIT THIS
summary['check']                                       = params.check


log.info summary.collect { k,v -> "${k.padRight(18)}: $v" }.join("\n")
log.info "-\033[2m--------------------------------------------------\033[0m-"

process check_md5 {
    input:
      tuple val(sample), file(primary), file(chksum)

    output:
        // File names prefixed with sample to handle instances of 'null.ext...'
        stdout

    shell = ['/bin/bash', '-euo', 'pipefail']

    // this just creates stdout required to allow flow
    stub:
        """
        echo -e "Sample\tSTDOUT\tSTDERR\tEXIT_CODE"
        echo -e "${sample}\tBlah out\tBlah err\t0"
        """

    script:
        """
        # md5 checksum files without a line feed are not accepted
        (cat ${chksum} && echo) | tr -s '\n' > tmp.chk

        echo -e "Sample\tOUTPUT"
        echo -en "${sample}\t"
        md5sum -c tmp.chk || true
        """
}

workflow {
    checks = Channel.fromPath(params.check)
    chk_map = checks.splitCsv(header: true).map { row -> tuple(row.sample, file(row.primary), file(row.chksum)) }

    main:
        check_md5(chk_map).collectFile(name: 'md5_results.txt', newLine: false, storeDir: params.outdir, keepHeader: true)
}
