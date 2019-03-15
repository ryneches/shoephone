library(phyloseq)
library(ggplot2)


ps6<-subset_taxa(ps5, Kingdom=="Bacteria")
ps6.ord.pcoa.bray <- ordinate(ps6, method="PCoA", distance="bray")

ps6_shoes<-subset_samples(ps6,Type=="shoe")
ps6_phone<-subset_samples(ps6,Type=="phone")
ps7<-merge_phyloseq(ps6_shoes,ps6_phone)

ps8<-subset_samples(ps7, Study=="cpr")

ps9<-subset_taxa(ps8,Family!="Mitochondria")

ps10 = prune_samples(sample_sums(ps9)>0, ps9)

anosim(otu_table(ps10), metadata$Type, "bray", permutations=999)

ps6.2<-subset_taxa(ps6,Family!="Mitochondria")
ps6.3=prune_samples(sample_sums(ps6.2)>0,ps6.2)
ps6.3.ord.pcoa.bray<-ordinate(ps6.3,"PCoA","bray")

ps6.3_football<-plot_ordination(ps6.3, ps6.3.ord.pcoa.bray, color="Type", title="" ) +theme( axis.text=element_text(size=20),axis.title=element_text(size=24,face="bold"),legend.title=element_text(size=38,face="bold"),legend.text=element_text(size=35),legend.background = element_rect(fill = 'white', colour = 'white'),panel.background = element_rect(fill = 'white', colour = 'white') ) +scale_color_manual(values = mycolors) + geom_point( size=3 )

png("PCoA_bray_football_ps6.3.png", 1600,1000);
ps6.3_football+labs(  x="\nPC1 - 15.2%\n",y="\nPC2 - 13.8%\n", title="", subtitle="")
dev.off()


ps10.ord.pcoa.bray<-ordinate(ps10,"PCoA","bray")

png("PCoA_bray_ASVs_ps10.png", 1600,1600)
ps10Taxa_phy<-plot_ordination(ps10, ps10.ord.pcoa.bray, type="Taxa", color="Phylum", title="\nPCoA ordination of Bray-Curtis distances split by Phyla\n")+labs(x="\nPC1 - 16.2%\n",y="\nPC2 - 13.2%\n")+facet_wrap(~Phylum, 3)+geom_point( size=5 )+theme_bw()+theme(panel.border = element_rect(colour="black",size=5,fill=NA), legend.position="none",axis.text.x = element_blank(),axis.text.y=element_blank(),plot.title = element_text(hjust = 0.5, size=40) )+ geom_abline(intercept = 0.011895159, slope = 1.456382159, color="black", size=2)+theme(strip.text.x = element_text(size = 24, colour = "black"))+theme(axis.title.y = element_text(size = 24, angle = 90))+theme(axis.title.x = element_text(size = 24, angle = 00))
ps10Taxa_phy
dev.off()
png("PCoA_bray_football_ps10.png", 1600,1000)

ps10_football<-plot_ordination(ps10, ps10.ord.pcoa.bray, color="Type", title="" ) +theme( axis.text=element_text(size=20),axis.title=element_text(size=24,face="bold"),legend.title=element_text(size=38,face="bold"),legend.text=element_text(size=35),legend.background = element_rect(fill = 'white', colour = 'white'),panel.background = element_rect(fill = 'white', colour = 'white') ) +scale_color_manual(values = mycolors) + geom_point( size=3 )+labs(x="\nPC1 - 16.2%\n",y="\nPC2 - 13.2%\n")
ps10_football+geom_abline(intercept = 0.011895159, slope = 1.456382159, color="black", size=2)

dev.off()

cbbPalette <- c("#000000", "#009E73", "#e79f00", "#9ad0f3", "#0072B2", "#D55E00", 
    "#CC79A7", "#F0E442")

ps10_football<-plot_ordination(ps10, ps10.ord.pcoa.bray, color="Type", title="" ) +theme( axis.text=element_text(size=20),axis.title=element_text(size=24,face="bold"),legend.title=element_text(size=38,face="bold"),legend.text=element_text(size=35),legend.background = element_rect(fill = 'white', colour = 'white'),panel.background = element_rect(fill = 'white', colour = 'white') ) +scale_color_manual(values = cbbPalette) + geom_point( size=5 )+labs(x="ÑnPC1 - 16.2%Ñn",y="ÑnPC2 - 13.2%Ñn")
png("PCoA_bray_football_ps10.CB.png", 1600,1000)
ps10_football
dev.off()

ps6.3_football<-plot_ordination(ps6.3, ps6.3.ord.pcoa.bray, color="Type", title="" ) +theme( axis.text=element_text(size=20),axis.title=element_text(size=24,face="bold"),legend.title=element_text(size=38,face="bold"),legend.text=element_text(size=35),legend.background = element_rect(fill = 'white', colour = 'white'),panel.background = element_rect(fill = 'white', colour = 'white') ) +scale_color_manual(values = cbbPalette) + geom_point( size=5 )
png("PCoA_bray_football_ps6.3.CB.png", 1600,1000)
ps6.3_football
dev.off()
