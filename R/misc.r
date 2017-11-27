
# .onLoad <- function (libname, pkgname) {
#     utils::globalVariables("hook_orig") # to suppress CHECK note
# }

.onAttach <- function (libname, pkgname) {
    if (Sys.info()["sysname"]=="Windows"){
        stataexe <- NULL
        for (d in c("C:/Program Files","C:/Program Files (x86)")) {
            if (dir.exists(d)) {
                #setwd(d)
                for (v in 11:15) {
                    dv <- paste(d,paste0("Stata",v), sep="/")
                    if (dir.exists(dv)) {
                        #setwd(dv)
                        for (f in c("Stata", "StataSE", "StataMP", 
                                    "Stata-64", "StataSE-64", "StataMP-64")) {
                            dvf <- paste(paste(dv, f, sep="/"), "exe", sep=".")
                            if (file.exists(dvf)) {
                                stataexe <- dvf
                                packageStartupMessage("Stata found at ", stataexe)
                                break
                            }
                        }
                    }
                }
            }
        }
    } else {
        packageStartupMessage("Specify the location of your Stata executable.")
    }
    
    knitr::opts_chunk$set(engine="stata", engine.path=stataexe, 
                          error=TRUE, comment="")
    
    stata_collectcode()
    # stataoutput_hookset()
    
}
