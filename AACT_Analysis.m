f = 'EMT_MasterDataSpreasheet_INCLUDED.xlsx';
T = readtable(f);
hdrs = T.Properties.VariableNames;

%Study 1: s = 1, ss = 1
%Study S1: s = 1, ss = 2
%Study S2: s = 2, ss = 1
%Study S3: s = 1, ss = 2

SS_indicator = {'Study 1', 'Study S1'; 'Study S2', 'Study S3'};
k = 0;
for s = 1:2 %Mturk || college
    for ss = 1:2 %animals/houses || furniture/paintings
        
        %Step 1. Select data (e.g., from Study 1)
        ds = T.Sample == s & T.StimSet == ss;
        fprintf('****** %s, N = %d *****\n',SS_indicator{s,ss},sum(ds));
        fprintf('\n');

        %Step 2A. E-EMT Accuracy
        fprintf('E-EMT Accuracy: different content condition: M = %1.2f, SE = %1.2f\n',mean(T.EmoCrossPropCorrect(ds)),std(T.EmoCrossPropCorrect(ds))/sqrt(length(T.EmoCrossPropCorrect(ds))));
        fprintf('E-EMT Accuracy: same content condition: M = %1.2f, SE = %1.2f\n',mean(T.EmoSamePropCorrect(ds)),std(T.EmoSamePropCorrect(ds))/sqrt(length(T.EmoSamePropCorrect(ds))));        
        foo = T.EmoCrossPropCorrect(ds) - T.EmoSamePropCorrect(ds);
        [~,P,~,STATS] = ttest(foo);
        fprintf('Paired sample T(%d) = %1.2f, p = %1.4f\n',STATS.df, STATS.tstat, P);        
        fprintf('95 CI: %1.2f, %1.2f\n',mean(foo)-1.96*std(foo)/sqrt(length(foo)), mean(foo)+1.96*std(foo)/sqrt(length(foo)));
        fprintf('CohenD = %1.2f\n',abs(mean(foo)/std(foo)));
        
        %Step 2B. E-EMT RT
        fprintf('\n');

        fprintf('E-EMT RT: different content condition: M = %1.2f, SE = %1.2f\n',mean(T.EmoCrossMedianRT(ds)),std(T.EmoCrossMedianRT(ds))/sqrt(length(T.EmoCrossMedianRT(ds))));
        fprintf('E-EMT RT: same content condition: M = %1.2f, SE = %1.2f\n',mean(T.EmoSameMedianRT(ds)),std(T.EmoSameMedianRT(ds))/sqrt(length(T.EmoSameMedianRT(ds))));        
        foo = T.EmoCrossMedianRT(ds) - T.EmoSameMedianRT(ds);
        [~,P,~,STATS] = ttest(foo);
        fprintf('Paired sample T(%d) = %1.2f, p = %1.4f\n',STATS.df, STATS.tstat, P);        
        fprintf('95 CI: %1.2f, %1.2f\n',mean(foo)-1.96*std(foo)/sqrt(length(foo)), mean(foo)+1.96*std(foo)/sqrt(length(foo)));
        fprintf('CohenD = %1.2f\n',abs(mean(foo)/std(foo)));
        
        %Step 2A. V-EMT Accuracy
        fprintf('\n');

        fprintf('V-EMT Accuracy: different content condition: M = %1.2f, SE = %1.2f\n',mean(T.ValCrossPropCorrect(ds)),std(T.ValCrossPropCorrect(ds))/sqrt(length(T.ValCrossPropCorrect(ds))));
        fprintf('V-EMT Accuracy: same content condition: M = %1.2f, SE = %1.2f\n',mean(T.ValSamePropCorrect(ds)),std(T.ValSamePropCorrect(ds))/sqrt(length(T.ValSamePropCorrect(ds))));        
        foo = T.ValCrossPropCorrect(ds) - T.ValSamePropCorrect(ds);
        [~,P,~,STATS] = ttest(foo);
        fprintf('Paired sample T(%d) = %1.2f, p = %1.4f\n',STATS.df, STATS.tstat, P);        
        fprintf('95 CI: %1.2f, %1.2f\n',mean(foo)-1.96*std(foo)/sqrt(length(foo)), mean(foo)+1.96*std(foo)/sqrt(length(foo)));
        fprintf('CohenD = %1.2f\n',abs(mean(foo)/std(foo)));
        
        %Step 2B. V-EMT RT
        fprintf('\n');

        fprintf('V-EMT RT: different content condition: M = %1.2f, SE = %1.2f\n',mean(T.ValCrossMedianRT(ds)),std(T.ValCrossMedianRT(ds))/sqrt(length(T.ValCrossMedianRT(ds))));
        fprintf('V-EMT RT: same content condition: M = %1.2f, SE = %1.2f\n',mean(T.ValSameMedianRT(ds)),std(T.ValSameMedianRT(ds))/sqrt(length(T.ValSameMedianRT(ds))));        
        foo = T.ValCrossMedianRT(ds) - T.ValSameMedianRT(ds);
        [~,P,~,STATS] = ttest(foo);
        fprintf('Paired sample T(%d) = %1.2f, p = %1.4f\n',STATS.df, STATS.tstat, P);        
        fprintf('95 CI: %1.2f, %1.2f\n',mean(foo)-1.96*std(foo)/sqrt(length(foo)), mean(foo)+1.96*std(foo)/sqrt(length(foo)));
        fprintf('CohenD = %1.2f\n',abs(mean(foo)/std(foo)));

        %Step 2C. Correlations between RT and accuracy task measures by
        %task
        fprintf('\n');        

        foo = [T.EmoSamePropCorrect(ds), T.EmoSameMedianRT(ds),T.EmoCrossPropCorrect(ds), T.EmoCrossMedianRT(ds)];
        fprintf('Correlation table: EEMT_Accuracy_Same, EEMT_RT_Same, EEMT_Accuracy_Diff, EEMT_RT_Diff\n');
        [r, p] = corrcoef(foo);
        disp(r)
        disp(p)

        foo = [T.ValSamePropCorrect(ds), T.ValSameMedianRT(ds),T.ValCrossPropCorrect(ds), T.ValCrossMedianRT(ds)];
        fprintf('Correlation table: VEMT_Accuracy_Same, VEMT_RT_Same, VEMT_Accuracy_Diff, VEMT_RT_Diff\n');
        [r, p] = corrcoef(foo);
        disp(r)
        disp(p)

        %Step 3. Correlations between inventories
        fprintf('\n');

        foo = [T.TAS20numScore(ds), T.PAQnumScore(ds), T.CESDnumScore(ds), T.AQnumScore(ds)];
        fprintf('Correlation table: TAS-20, PAQ, CES-D, AQ\n');
        [r, p] = corrcoef(foo);
        disp(r)
        disp(p)


        %Step 3. Correlations between inventories with accuracy and RT
        fprintf('\n');
        
        foo = [T.EmoPropCorrect(ds), T.EmoMedianRT(ds), T.TAS20numScore(ds), T.PAQnumScore(ds), T.CESDnumScore(ds), T.AQnumScore(ds)];
        [r1, p1] = corrcoef(foo);

        foo = [T.ValPropCorrect(ds), T.ValMedianRT(ds), T.TAS20numScore(ds), T.PAQnumScore(ds), T.CESDnumScore(ds), T.AQnumScore(ds)];
        [r2, p2] = corrcoef(foo);
        
        fprintf('Correlation table: Task Performance X Trait Measures\n');
        disp([r1(3:end,1:2), r2(3:end,1:2)])
        disp([p1(3:end,1:2), p2(3:end,1:2)])       

        %Step 4 PCA
        foo = [T.TAS20numScore(ds), T.PAQnumScore(ds), T.CESDnumScore(ds), T.AQnumScore(ds),...
            T.EmoPropCorrect(ds), T.ValPropCorrect(ds), T.EmoMedianRT(ds), T.ValMedianRT(ds)];
        [coeff, score, latent, tsquared, explained] = pca(normalize(foo));
        unscaled_loading = coeff.*sqrt(latent)';
        fprintf('PCA: Component matrix SPSS (coeff*sqrt(latent)), 2 dimensions\n')
        disp(unscaled_loading(:,1:2));


        %Step 5 - Table 6
        foo = [T.EmoPropCorrect(ds), T.ValPropCorrect(ds), ...
        T.TAS20numScore(ds), T.PAQnumScore(ds), T.CESDnumScore(ds), T.AQnumScore(ds)];
        [r, p] = corrcoef(foo);
        k = k+1;
        table6_r_EEMT(:,k) = r(3:end,1);
        table6_r_VEMT(:,k) = r(3:end,2);
        table6_p_EEMT(:,k) = p(3:end,1);
        table6_p_VEMT(:,k) = p(3:end,2);

    end %for ss
end %for s

fprintf('Correlations between Individual Difference Measures and Matching Accuracy across All Studies\n');
fprintf('See Table 6\n')
disp([table6_r_EEMT, table6_r_VEMT])
disp([table6_p_EEMT, table6_p_VEMT])