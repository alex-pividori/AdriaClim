#******************************************************************************
#
# DESCRIPTION:      This R script read a collection of in-situ measured and 
#                   hindcast simulated data ( by COPERNICUS-Marine service)
#                   and represent in a scatter plot the delta value
#                   of temperature of salinity in function of depth.
#                   The depth goes 0.25 m by 0.25 m depth.
# EXTERNAL CALLS:   none.
#
# EXTERNAL FILES:   - .txt: CSV file containing data collected on different columns for single samples
#
#
# DEVELOPER:         Alex Pividori (alex.pividori@arpa.fvg.it)
#                    ARPA FVG - S.O.C. Stato dell'Ambiente - CRMA
#                    "AdriaClim" Interreg IT-HR project
#
# SOFTWARE VERSION: R version r/3.5.2/intel/19.1.1.217-nyr7hab
#
#
# CREATION DATE:    09/08/2021
#
# MODIFICATIONS:    10/08/2021 --> Addition of mode function
#
# VERSION:          0.1.
#
#******************************************************************************

#======================= Temperature VERSION ===========================

args <- commandArgs(trailingOnly = TRUE)

         gr=args[1]
         se=args[2]
    se_name=args[3]
  input_dir=args[4]
 output_dir=args[5]

#======================================================================

se_label=se            

info_file  <- read.csv2( paste( input_dir , "/selected_S_files_bydepth.txt", sep="") , header=FALSE , dec=".")
 info_dim  <- dim(info_file)

colors_rgb <- 1:info_dim[1]

depth_inf  <- info_file[,2]
depth_sup  <- info_file[,3]
   x_names <- paste( info_file[,2] , "\U00F7" , info_file[,3] , sep="" )
file_names <- info_file[,1]

for (i in 1:info_dim[1]){
       data_name <- paste("a_" , i , sep="")
    assign( data_name , read.table( paste( input_dir , "/" , file_names[i] , sep="" ) , header=FALSE , sep=";") )
    colors_rgb[i] = as.numeric(i/info_dim[1])  
}

  date_start = min(as.Date(a_1[,4]))
  date_fin   = max(as.Date(a_1[,4]))
bottom_depth = max(depth_sup[i])

pdf(file = paste( output_dir , "/arpae_boxplot_delta_S_" , gr , "_" , se_name , ".pdf", sep="" ) )

if ( info_dim[1] == 6 ) {

boxplot( a_1[,8] - a_1[,7] , a_2[,8] - a_2[,7] , a_3[,8] - a_3[,7], a_4[,8] - a_4[,7] , a_5[,8] - a_5[,7] , a_6[,8] - a_6[,7] ,
        main=paste( "NEMO: S(model)-S(meas) \n Data:", gr , " Period:",se_label ),
#        width=c(0.2,0.2,0.2,0.2,0.2,0.2),
        xlab="Depth[m]" ,
#        xlim=c(1,bottom_depth - 1.75) ,
#        ylim=c( -2.5 , 6.5 ),
        ylab="Sh-Sm [PSU]",
        at=depth_inf + (depth_sup - depth_inf)/2 ,
        col=rgb(colors_rgb , 1.0 - colors_rgb , 0.0) ,
        sub=paste("Collected Data: from" , date_start , "to" , date_fin ),
        names=x_names )
        mean_val=c( mean(a_1[,8] - a_1[,7]), mean(a_2[,8] - a_2[,7]) , mean(a_3[,8] - a_3[,7]),  mean(a_4[,8] - a_4[,7]),
                    mean(a_5[,8] - a_5[,7]) , mean(a_6[,8] - a_6[,7]) )

} else if ( info_dim[1] == 5 ) {

boxplot( a_1[,8] - a_1[,7], a_2[,8] - a_2[,7], a_3[,8] - a_3[,7], a_4[,8] - a_4[,7], mean(a_5[,8] - a_5[,7]),
        main=paste( "NEMO: S(model)-S(meas) \n Data:", gr , " Period:",se_label ),
 #       width=c(0.2,0.2,0.2,0.2,0.2),
        xlab="Depth[m]" ,
  #      xlim=c(2, 24.5) ,
  #      ylim=c( -2.5 , 6.5 ),
        ylab="Sh-Sm [PSU]",
        at=depth_inf + (depth_sup - depth_inf)/2 ,
        col=rgb(colors_rgb , 1.0 - colors_rgb , 0.0) ,
        sub=paste("Collected Data: from" , date_start , "to" , date_fin ),
        names=x_names )
        mean_val=c( mean(a_1[,8] - a_1[,7]), mean(a_2[,8] - a_2[,7]) , mean(a_3[,8] - a_3[,7]),  mean(a_4[,8] - a_4[,7]), mean(a_5[,8] - a_5[,7]) )

} else if ( info_dim[1] == 4 ) {

boxplot( a_1[,8] - a_1[,7] , a_2[,8] - a_2[,7] , a_3[,8] - a_3[,7], a_4[,8] - a_4[,7] ,
        main=paste( "NEMO: S(model)-S(meas) \n Data:", gr , " Period:",se_label ),
 #       width=c(0.2,0.2,0.2,0.2),
        xlab="Depth[m]" ,
 #       xlim=c(2, 24.5) ,
 #       ylim=c( -2.5 , 6.5 ),
        ylab="Sh-Sm [PSU]",
        at=depth_inf + (depth_sup - depth_inf)/2 ,
        col=rgb(colors_rgb , 1.0 - colors_rgb , 0.0) ,
        sub=paste("Collected Data: from" , date_start , "to" , date_fin ),
        names=x_names )
        mean_val=c( mean(a_1[,8] - a_1[,7]), mean(a_2[,8] - a_2[,7]) , mean(a_3[,8] - a_3[,7]),  mean(a_4[,8] - a_4[,7]) )

} else if ( info_dim[1] == 3 ) {

boxplot( a_1[,8] - a_1[,7] , a_2[,8] - a_2[,7] , a_3[,8] - a_3[,7],
        main=paste( "NEMO: S(model)-S(meas) \n Data:", gr , " Period:",se_label ),
  #      width=c(0.2,0.2,0.2),
        xlab="Depth[m]" ,
  #      xlim=c(2, 24.5) ,
  #      ylim=c( -2.5 , 6.5 ),
        ylab="Sh-Sm [PSU]",
        at=depth_inf + (depth_sup - depth_inf)/2 ,
        col=rgb(colors_rgb , 1.0 - colors_rgb , 0.0) ,
        sub=paste("Collected Data: from" , date_start , "to" , date_fin ),
        names=x_names )
        mean_val=c( mean(a_1[,8] - a_1[,7]), mean(a_2[,8] - a_2[,7]) , mean(a_3[,8] - a_3[,7]) )
}

#=============================================================================

abline(h=(seq(-50,-1,1)), col="black", lty="dotted")
abline(h=(seq( 1, 50,1)), col="black", lty="dotted")

# mean_tot is the mean on the total periodi considered (2020-07 to 2021-07)

#======================================================================

  labels_val=round( mean_val , digits=2 )

#if ( se=="tot") {
#points(depth_inf + (depth_sup - depth_inf)/2 , mean_val, pch = 21, col="black", bg="red" )
#legend( "topright", legend=c("Annual mean"), col=c("red"), pch=c(19) , cex=1.0 , bg="white")
#} else {
points(depth_inf + (depth_sup - depth_inf)/2 , mean_val, pch = 21, col="black", bg="blue")
#points(depth_inf + (depth_sup - depth_inf)/2 , mean_tot, pch = 21, col="black", bg="red" )
legend( "topright", legend=c("Mean value"), col=c("blue"), pch=c(19) , cex=1.0 , bg="white" )
#}

text(depth_inf + (depth_sup - depth_inf)/2 , mean_val, labels=labels_val  , font=2, cex=0.75, adj=c(-0.5,0) )

abline(h=0, col="black" , lty=2 )
