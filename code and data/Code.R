library(ConnectednessApproach)
library(zoo)  
library(devtools)
library(ggplot2)
library(kableExtra)
library(readxl)

data_whole <- read_excel("C:/Users/aryan/Downloads/Fram Raw Data.xlsx", 
                         col_types = c("date", "numeric", "numeric", 
                                       "numeric", "numeric", "numeric", 
                                       "numeric", "numeric", "numeric", 
                                       "numeric"))
View(data_whole)
write.csv(data_whole, file = "Data_AI_Token_Energy.csv", row.names = F)
dat <- read.csv.zoo("Data_AI_Token_Energy.csv", sep = ',', header = T)

dat_data = read.csv(file = "Data_AI_Token_Energy.csv",header = T);
dat_dates <- as.Date(dat_data[,1]);
dat_data<- zoo(dat_data[,2:10], dat_dates);

# SUMMARY STATISTICS
kbl(SummaryStatistics(dat_data, correlation="pearson"))
kbl(SummaryStatistics(dat_data, correlation="kendal"))


  dca0.95_t = ConnectednessApproach(dat_data,
                                    nlag= 1,
                                    nfore= 100,
                                    window.size =200,
                                    model="QVAR",
                                    connectedness="Time",
                                    VAR_config=list(QVAR = list(tau = 0.95)))
kbl(dca0.95_t$TABLE)

dca0.05_t = ConnectednessApproach(dat_data,
                                  nlag=1,
                                  nfore=100,
                                  window.size =200,
                                  model="QVAR",
                                  connectedness="Time",
                                  VAR_config=list(QVAR = list(tau = 0.05)))
kbl(dca0.05_t$TABLE)

dca0.5_t = ConnectednessApproach(dat_data,
                                 nlag=1,
                                 nfore=100,
                                 window.size =200,
                                 model="QVAR",
                                 connectedness="Time",
                                 VAR_config=list(QVAR = list(tau = 0.5)))

kbl(dca0.5_t$TABLE)

#TCI Figue 1: Dynamic Total Connectedness
png(filename ="TCI_T95.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotTCI(dca0.95_t)
dev.off()

png(filename ="TCI_T5.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotTCI(dca0.05_t)
dev.off()

png(filename ="TCI_T50.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotTCI(dca0.5_t)
dev.off()

#NET Figure 2:Net Total Directional Connectedness
png(filename ="NET_T95.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNET(dca0.95_t)
dev.off()

png(filename ="NET_T50.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNET(dca0.5_t)
dev.off()

png(filename ="NET_T5.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNET(dca0.05_t)
dev.off()

#NPDC Figure 3:Net Pairwise Directional Connectedness
png(filename ="NDPC_T95.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNPDC(dca0.95_t)
dev.off()

png(filename ="NDPC_T50.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNPDC(dca0.5_t)
dev.off()

png(filename ="NDPC_T5.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNPDC(dca0.05_t)
dev.off()

#PCI Figure 4:For Dynamic Pairwise Connectedness
png(filename ="PCI_T95.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotPCI(dca0.95_t)
dev.off()

png(filename ="PCI_T50.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotPCI(dca0.5_t)
dev.off()

png(filename ="PCI_T5.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotPCI(dca0.05_t)
dev.off()

#Network Figure 5:Network Plot
png(filename ="Network_T95.png",width = 35,height = 20.95,units = "cm",res = 700)
PlotNetwork(dca0.95_t)
dev.off()

png(filename ="Network_T5.png",width = 35,height = 20.95,units = "cm",res = 700)
PlotNetwork(dca0.05_t)
dev.off()

png(filename ="Network_T50.png",width = 35,height = 20.95,units = "cm",res = 700)
PlotNetwork(dca0.5_t)
dev.off()


  dca0.5_f=ConnectednessApproach(
    dat_data,
    nlag = 1,
    nfore = 100,
    window.size =200,
    corrected = FALSE,
    model = "QVAR",
    connectedness = "Frequency",
    VAR_config=list(QVAR = list(tau = 0.5)),
    Connectedness_config = list(FrequencyConnectedness = list(partition = c(pi+0.00001, pi/5,pi/20, 0), generalized = TRUE,scenario = "ABS")))
kbl(dca0.5_f$TABLE)

dca0.05_f=ConnectednessApproach(
  dat_data,
  nlag = 1,
  nfore = 100,
  window.size =200,
  corrected = FALSE,
  model = "QVAR",
  connectedness = "Frequency",
  VAR_config=list(QVAR = list(tau = 0.05)),
  Connectedness_config = list(FrequencyConnectedness = list(partition = c(pi+0.00001, pi/5,pi/20, 0), generalized = TRUE,scenario = "ABS")))
kbl(dca0.05_f$TABLE)

dca0.95_f=ConnectednessApproach(
  dat_data,
  nlag = 1,
  nfore = 100,
  window.size =200,
  corrected = FALSE, 
  model = "QVAR",
  connectedness = "Frequency",
  VAR_config=list(QVAR = list(tau = 0.95)),
  Connectedness_config = list(FrequencyConnectedness = list(partition = c(pi+0.00001, pi/5,pi/20, 0), generalized = TRUE,scenario = "ABS")))
kbl(dca0.95_f$TABLE)

#TCI Figue 1: Dynamic Total Connectedness
png(filename ="TCI_F95.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotTCI(dca0.95_f)
dev.off()

png(filename ="TCI_F5.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotTCI(dca0.05_f)
dev.off()

png(filename ="TCI_F50.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotTCI(dca0.5_f)
dev.off()

#NET Figure 2:Net Total Directional Connectedness
png(filename ="NET_F95.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNET(dca0.95_f)
dev.off()

png(filename ="NET_F50.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNET(dca0.5_f)
dev.off()

png(filename ="NET_F5.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNET(dca0.05_f)
dev.off()

#NPDC Figure 3:Net Pairwise Directional Connectedness
png(filename ="NDPC_F95.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNPDC(dca0.95_f)
dev.off()

png(filename ="NDPC_F50.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNPDC(dca0.5_f)
dev.off()

png(filename ="NDPC_F5.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotNPDC(dca0.05_f)
dev.off()

#PCI Figure 4:For Dynamic Pairwise Connectedness
png(filename ="PCI_F95.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotPCI(dca0.95_f)
dev.off()

png(filename ="PCI_F50.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotPCI(dca0.5_f)
dev.off()

png(filename ="PCI_F5.png",width = 35,height = 20.95,units = "cm",res = 300)
PlotPCI(dca0.05_f)
dev.off()

#Network Figure 5:Network Plot
png(filename ="Network_F95.png",width = 35,height = 20.95,units = "cm",res = 700)
PlotNetwork(dca0.95_f)
dev.off()

png(filename ="Network_F5.png",width = 35,height = 20.95,units = "cm",res = 700)
PlotNetwork(dca0.05_f)
dev.off()

png(filename ="Network_F50.png",width = 35,height = 20.95,units = "cm",res = 700)
PlotNetwork(dca0.5_f)
dev.off()


  table_0.5=dca0.5_f$TABLE;
to_0.5=dca0.5_f$TO;
from_0.5=dca0.5_f$FROM;
net_0.5=dca0.5_f$NET;
total_0.5=dca0.5_f$TCI;
NPT_0.5=dca0.5_f$NPT;
PCI_0.5=dca0.5_f$PCI;
NPDC_0.5=dca0.5_f$NPDC;

table_0.95=dca0.95_f$TABLE;
to_0.95=dca0.95_f$TO;
from_0.95=dca0.95_f$FROM;
net_0.95=dca0.95_f$NET;
total_0.95=dca0.95_f$TCI;
NPT_0.95=dca0.95_f$NPT;
PCI_0.95=dca0.95_f$PCI;
NPDC_0.95=dca0.95_f$NPDC;

table_0.05=dca0.05_f$TABLE;
to_0.05=dca0.05_f$TO;
from_0.05=dca0.05_f$FROM;
net_0.05=dca0.05_f$NET;
total_0.05=dca0.05_f$TCI;
NPT_0.05=dca0.05_f$NPT;
PCI_0.05=dca0.05_f$PCI;
NPDC_0.05=dca0.05_f$NPDC;

# extract main variables in the time domain 
table_0.5_t=dca0.5_t$TABLE;
to_0.5_t=dca0.5_t$TO;
from_0.5_t=dca0.5_t$FROM;
net_0.5_t=dca0.5_t$NET;
total_0.5_t=dca0.5_t$TCI;
NPT_0.5_t=dca0.5_t$NPT;
PCI_0.5_t=dca0.5_t$PCI;
NPDC_0.5_t=dca0.5_t$NPDC;

table_0.95_t=dca0.95_t$TABLE;
to_0.95_t=dca0.95_t$TO;
from_0.95_t=dca0.95_t$FROM;
net_0.95_t=dca0.95_t$NET;
total_0.95_t=dca0.95_t$TCI;
NPT_0.95_t=dca0.95_t$NPT;
PCI_0.95_t=dca0.95_t$PCI;
NPDC_0.95_t=dca0.95_t$NPDC;

table_0.05_t=dca0.05_t$TABLE;
to_0.05_t=dca0.05_t$TO;
from_0.05_t=dca0.05_t$FROM;
net_0.05_t=dca0.05_t$NET;
total_0.05_t=dca0.05_t$TCI;
NPT_0.05_t=dca0.05_t$NPT;
PCI_0.05_t=dca0.05_t$PCI;
NPDC_0.05_t=dca0.05_t$NPDC;

# export csv tables in the time domain
write.csv(table_0.5_t,"table_0.5_time.csv")
write.csv(net_0.5_t,"net_0.5_time.csv")      
write.csv(from_0.5_t,"from_0.5_time.csv")  
write.csv(to_0.5_t,"to_0.5_time.csv") 
write.csv(PCI_0.5_t,"pairwise_0.5_time.csv") 
write.csv(total_0.5_t,"total_0.5_time.csv") 
write.csv(NPT_0.5_t,"NPT_0.5_time.csv") 
write.csv(NPDC_0.5_t,"NPDC_0.5_time.csv") 


write.csv(table_0.05_t,"table_0.05_time.csv")
write.csv(net_0.05_t,"net_0.05_time.csv")      
write.csv(from_0.05_t,"from_0.05_time.csv")  
write.csv(to_0.05_t,"to_0.05_time.csv") 
write.csv(PCI_0.05_t,"pairwise_0.05_time.csv") 
write.csv(total_0.05_t,"total_0.05_time.csv") 
write.csv(NPT_0.05_t,"NPT_0.05_time.csv") 
write.csv(NPDC_0.05_t,"NPDC_0.05_time.csv") 


write.csv(table_0.95_t,"table_0.95_time.csv")
write.csv(net_0.95_t,"net_0.95_time.csv")      
write.csv(from_0.95_t,"from_0.95_time.csv")  
write.csv(to_0.95_t,"to_0.95_time.csv") 
write.csv(PCI_0.95_t,"pairwise_0.95_time.csv") 
write.csv(total_0.95_t,"total_0.95_time.csv") 
write.csv(NPT_0.95_t,"NPT_0.95_time.csv") 
write.csv(NPDC_0.95_t,"NPDC_0.95_time.csv") 


# export csv tables in the frequency domain
write.csv(table_0.5,"table_0.5_f.csv")
write.csv(net_0.5,"net_0.5_f.csv")      
write.csv(from_0.5,"from_0.5_f.csv")  
write.csv(to_0.5,"to_0.5_f.csv") 
write.csv(PCI_0.5,"pairwise_0.5_f.csv") 
write.csv(total_0.5,"total_0.5_f.csv") 
write.csv(NPT_0.5,"NPT_0.5_f.csv") 
write.csv(NPDC_0.5,"NPDC_0.5_f.csv") 

write.csv(table_0.05,"table_0.05_f.csv")
write.csv(net_0.05,"net_0.05_f.csv")      
write.csv(from_0.05,"from_0.05_f.csv")  
write.csv(to_0.05,"to_0.05_f.csv") 
write.csv(PCI_0.05,"pairwise_0.05_f.csv") 
write.csv(total_0.05,"total_0.05_f.csv") 
write.csv(NPT_0.05,"NPT_0.05_f.csv") 
write.csv(NPDC_0.05,"NPDC_0.05_f.csv") 

write.csv(table_0.95,"table_0.95_f.csv")
write.csv(net_0.95,"net_0.95_f.csv")      
write.csv(from_0.95,"from_0.95_f.csv")  
write.csv(to_0.95,"to_0.95_f.csv") 
write.csv(PCI_0.95,"pairwise_0.95_f.csv") 
write.csv(total_0.95,"total_0.95_f.csv") 
write.csv(NPT_0.95,"NPT_0.95_f.csv") 
write.csv(NPDC_0.95,"NPDC_0.95_f.csv") 