Files description for the Cellphone and Shoes analysis

The 4 datasets involved are:
CPR - Cell Phone Russell (Eisenlab, not yet public)
SPM - SPace station Microbes https://dash.ucdavis.edu/stash/dataset/doi:10.25338/B89G6C (also available on NCBI, BioProject PRJNA376404 )
CPM - Cell Phone Meadows https://figshare.com/articles/Meadow_etal_Phones/1000786
CPJ - Cell Phone Jack https://figshare.com/articles/Forensic_analysis_of_the_microbiome_of_phones_and_shoes/1311743

*Sample lists for the CPR dataset split by lanes
CPR_list1.txt
CPR_list2.txt
CPR_list3.txt
CPR_list4.txt

copy_Rcommands.pl - Script used to generate altenate version of the R script used for each data set
copy_Rcommands_BigData.pl - Same as above but using the BigData protocol for DADA2
copy_Rcommands_CPR_BigData.pl - Same as above to split the CPR commands for each lane
filter_sample_list.pl - Script used to remove samples that did not have enough reads to pass the QC filters
find_missing_CPR.pl - Script used to remove empty files from the CPR data set
rearrange_CPR_data.pl - Script used to move the CPR data into their appropriate lane folders.
rename_rawfiles.pl - Script used to rename the raw files into the naming scheme described above.
trim_CPM_seqs.pl - Script used to trim the CPM dataset down to 150 base pairs

CellPhone_Shoes_Rscripts.tgz - Rscripts archive
CellPhone_Shoes_perlscripts.tgz - Perl scripts archive
CellPhone_Shoes_rdsfiles.tgz - DADA2 output archive

seqtabCPJ.rds - seqtab R object for CPJ data set
seqtabCPM.rds - seqtab R object for CPM data set
seqtabCPR.rds - seqtab R object for the CPR data set all 4 lanes processed at once
seqtabCPR1.rds - seqtab R object for the CPR data lane 1
seqtabCPR2.rds - seqtab	R object for the CPR data lane 2
seqtabCPR3.rds - seqtab	R object for the CPR data lane 3
seqtabCPR4.rds - seqtab	R object for the CPR data lane 4
seqtabSPM.rds - seqtab	R object for the SPM data set
seqtab_CPR_CPM_CPJ_SPM.rds - Merged seqtab R object using CPR1, CPR2, CPR3, CPR4, CPM, CPJ and SPM objects
tax_CPR_CPM_CPJ_SPM.rds - tax R object of seqtab_CPR_CPM_CPJ_SPM with taxonomy added


The following files contain R commands used for each data set. BigData means that the BigData protocol was used.
Magic numbers were used in the BigData files to determine the loop boundaries. Visual inspection.
I'm sure there is a way to get such number automatically using some code but I added it manually.

R_commands_CPJ.txt
R_commands_CPJ_BigData.txt
R_commands_CPM.txt
R_commands_CPM_BigData150.txt - BigData protocol used on the 150bp version of the CPM data set.
R_commands_CPR.txt
R_commands_CPR1_BigData.txt
R_commands_CPR2_BigData.txt
R_commands_CPR3_BigData.txt
R_commands_CPR4_BigData.txt
R_commands_CPR_BigData.txt
R_commands_SPM.txt
R_commands_merging.txt - Rscript used AFTER generating all the individual seqtab object to merge into 1.


filtering_stats.tgz - number of reads before and after filtering for each sample split by data sets
