# shoephone
Community analysis of cell phones and shoes : Project MERCCURI

## Datasets

* CPM CellPhoneMeadows (250 bp)
> [*Mobile phones carry the personal microbiome of their owners*](https://peerj.com/articles/447/), James F. Meadow, Adam E. Altrichter, Jessica L. Green, **PeerJ**
* SPM SPaceMicrobes (150 bp)
> [*A microbial survey of the International Space Station (ISS)*](https://peerj.com/articles/4029/), Jenna M. Lang, David A. Coil, Russell Y. Neches, Wendy E. Brown, Darlene Cavalier, Mark Severance, Jarrad T. Hampton-Marcell, Jack A. Gilbert, Jonathan A. Eisen, **PeerJ**
* CPJ CellPhoneJack (150 bp)
> [*Forensic analysis of the microbiome of phones and shoes*](https://microbiomejournal.biomedcentral.com/articles/10.1186/s40168-015-0082-9), Simon Lax, Jarrad T Hampton-Marcell, Sean M Gibbons, Ge&oacute;rgia Barguil Colares, Daniel Smith, Jonathan A Eisen and Jack A Gilbert, **BMC Microbiome**
* CPR CellPhoneRussell (150 bp)
> (this manuscript)

## Manifest

Read data for Cell phones and shoes dataset (CPR) can be found at BioProject [PRJNA470730](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA470730),
and from the SRA under accession number [SRP145522](https://www.ncbi.nlm.nih.gov/sra/SRP145522).

* `data`
  * `dada2`
    * `seqtab_CPR_CPM_CPJ_SPM.rds` : Sequence table for all datasets, R object
    * `tax_CPR_CPM_CPJ_SPM.rds` : Taxon table for all datasets, R object
  * `qiime`
    * `shoephone_mapping.tsv` : Mapping file for CPR dataset
    * `table_even1000.biom` : BIOM table for CPR dataset
    * `table_even1000.json` : BIOM table for CPR dataset (JSON format)
  * `jfmeadow`
    * `phones_map.txt` : Mapping file for CPM dataset
  * `jlang`
    * `ISS.txt` : Mapping file for SPM dataset
  * `slax`
    * `mapping_file.txt` : Mapping file for CPJ dataset
* `figures`
  * `PCoA_bray_type.png` : PCoA plot of samples from all datasets, coded by sample type
* `README.md` : This file
* `ShoePhone.ipynb` : Jupyter notebook detailing the analysis carried out for this paper
* `all_metadata.tsv` : Combined metadata for all four studies
* `sequences.fasta` : ASV (amplicon sequence variant) sequences found in CPR study
* `sequences.tree` : Approximate maximum likelihood tree of ASVs
* `sequences.seqnames.tree` : Approximate maximum likelihood tree of ASVs, using sequences as names (needed for `phyloseq`)
* `shoephone_all_taxa.csv.gz` : ASV taxonomic assignments
