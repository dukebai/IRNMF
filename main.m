

         B1=virusdrug;
        % B1(:,4)=0;
          Vp=find(B1()==1);
        Vn=find(B1()==0);
         MatPredict=zeros(210,34);
       Ip=crossvalind('Kfold',numel(Vp),5);
        In=crossvalind('Kfold',numel(Vn),5);
         for I=1:5
             I
           vp=Ip==I;
           vn=In==I;
              matDT=B1;
             matDT(Vp(vp))=0; 

     recMatrix=SMF(matDT,drugsim,virussim,18,1500,1,1,1);

            V=[Vn(vn);Vp(vp)];
             MatPredict(V)=recMatrix(V);
           end
     [AUC,AUPR,Acc,Sen,Spe,Pre]=ROCcompute1(MatPredict(),B1(),1);  

        
       
       
  