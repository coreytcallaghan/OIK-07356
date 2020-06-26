# Avian trait specialization is negatively associated with urban tolerance (https://doi.org/10.1111/oik.07356)

This repository contains code and data to reproduce Callaghan et al. 2020. The raw eBird data are not included here, but the summarized/aggregated urban scores are included for 256 species of European breeding birds. The R information used at the time of analysis is as follows:

> sessionInfo()
R version 3.5.0 (2018-04-23)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)

Matrix products: default

locale:
[1] LC_COLLATE=English_Australia.1252  LC_CTYPE=English_Australia.1252    LC_MONETARY=English_Australia.1252
[4] LC_NUMERIC=C                       LC_TIME=English_Australia.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] MuMIn_1.40.4    ggtree_1.14.6   tibble_3.0.0    phytools_0.6-60 maps_3.3.0      phylosignal_1.2
 [7] phylobase_0.8.4 phangorn_2.4.0  ape_5.2         lubridate_1.7.4 readr_1.3.1     scales_1.0.0   
[13] ggplot2_3.3.0   purrr_0.3.2     dplyr_0.8.3    

loaded via a namespace (and not attached):
 [1] nlme_3.1-137            gmodels_2.16.2          progress_1.2.0          httr_1.4.1             
 [5] numDeriv_2016.8-1       tools_3.5.0             R6_2.2.2                vegan_2.5-2            
 [9] spData_0.2.8.3          DBI_1.0.0               lazyeval_0.2.1          mgcv_1.8-28            
[13] colorspace_1.4-1        permute_0.9-4           ade4_1.7-11             withr_2.1.2            
[17] sp_1.3-1                tidyselect_0.2.5        prettyunits_1.0.2       mnormt_1.5-5           
[21] compiler_3.5.0          cli_1.0.1               adephylo_1.1-11         animation_2.6          
[25] expm_0.999-3            xml2_1.2.2              quadprog_1.5-5          stringr_1.4.0          
[29] digest_0.6.17           pkgconfig_2.0.2         htmltools_0.4.0         plotrix_3.7-4          
[33] rlang_0.4.5             rstudioapi_0.8          shiny_1.1.0             jsonlite_1.6.1         
[37] combinat_0.0-8          gtools_3.8.1            spdep_0.7-7             magrittr_1.5           
[41] Matrix_1.2-14           Rcpp_1.0.2              munsell_0.5.0           lifecycle_0.2.0        
[45] scatterplot3d_0.3-41    stringi_1.4.3           yaml_2.2.1              clusterGeneration_1.3.4
[49] MASS_7.3-51.5           plyr_1.8.4              grid_3.5.0              parallel_3.5.0         
[53] gdata_2.18.0            promises_1.0.1          crayon_1.3.4            adegenet_2.1.1         
[57] deldir_0.1-15           rncl_0.8.2              lattice_0.20-35         splines_3.5.0          
[61] hms_0.4.2               pillar_1.4.3            igraph_1.2.1            uuid_0.1-2             
[65] boot_1.3-20             seqinr_3.4-5            stats4_3.5.0            reshape2_1.4.3         
[69] fastmatch_1.1-0         LearnBayes_2.15.1       XML_3.99-0.3            glue_1.3.0             
[73] RNeXML_2.1.1            BiocManager_1.30.10     treeio_1.6.2            vctrs_0.2.4            
[77] httpuv_1.4.3            gtable_0.2.0            tidyr_1.0.0             assertthat_0.2.0       
[81] mime_0.5                xtable_1.8-2            tidytree_0.3.1          coda_0.19-2            
[85] later_0.7.2             rvcheck_0.1.7           cluster_2.0.7-1         ellipsis_0.3.0

If you have any questions about the data, analysis, or research, please reach out to Corey Callaghan (callaghan.corey.t@gmail.com).
