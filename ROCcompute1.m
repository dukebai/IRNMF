function [AUC,AUPR,Acc,Sen,Spe,Pre]=ROCcompute1(predictList,trueList,plotOption)
         if size(predictList,2)>1
            predictList=reshape(predictList,numel(predictList),1);
            trueList=reshape(trueList,numel(trueList),1);
         end
        low=min(predictList);
         high=max(predictList);
         threshold=linspace(high,low,1000);
         
         Sen=zeros(1,1000); Spe=zeros(1,1000); Pre=zeros(1,1000);
         Acc=zeros(1,1000);
         for I=1:1000
             Vector=zeros(numel(predictList),1);
             v=predictList>=threshold(I);
             Vector(v)=1;
             tp=sum(Vector==1&trueList==1);
             tn=sum(Vector==0&trueList==0);
             np=sum(Vector==1&trueList==0);
             nn=sum(Vector==0&trueList==1);
             
             if tp+nn==0
                Sen(I)=1;
             else
                Sen(I)=tp/(tp+nn);
             end
           
             if tn+np==0
                Spe(I)=1;
             else
                Spe(I)=tn/(tn+np);
             end
          
             if tp+np==0
                Pre(I)=1;
             else
                Pre(I)=tp/(tp+np);
             end
            
             Acc(I)=(tn+tp)/(tn+tp+np+nn);
         end
         
         Sen=[0,Sen];Spe=[1,Spe];Pre=[1,Pre];
         Acc=[sum(trueList==0)/length(trueList) Acc];
         
         AUC=abs(trapz(1-Spe,Sen));
         AUPR=abs(trapz(Sen,Pre));
         
         if plotOption==1
            plot(1-Spe,Sen,'--g','LineWidth',2);  %'color',[255/255 128/255 64/255]
            axis([0 1.00 0 1.00]);
            xlabel('FPR');
            ylabel('TPR');
           legend('IRNMFVDA(AUC=0.8127)')
           figure;
            plot(Sen,Pre,'--r','LineWidth',2);
            axis([0 1.00 0 1.00]);
            xlabel('Sen');
            ylabel('Pre');

         end
         
         