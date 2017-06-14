global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 3;
global borders
borders = 1;
global constant
constant = 0.00038172;
global convection
convection = 0;
global dd
dd = 0.005;
global density
density = 910;
global density2
density2 = 1600;
global dimensions
dimensions = 2;
global distribution
distribution = 2;
global distributionFrequency
distributionFrequency = 12;
global dt
dt = 0.05;
global elevFrequency
elevFrequency = 12;
global elevLocation
elevLocation = 4;
global elevatedTemp
elevatedTemp = 250;
global emissivity
emissivity = 0.97;
global energyRate
energyRate = 20;
global extraConduction
extraConduction = 0;
global extraConvection
extraConvection = 0;
global extraRadiation
extraRadiation = 0;
global finalTemps
finalTemps = ['0.45881     0.45805     0.45659     0.45447      0.4518      0.4487      0.4453     0.44172     0.43808      0.4345     0.43107     0.42787     0.42493      0.4223        0.42     0.41803     0.41638     0.41503     0.41398     0.41318     0.41262     0.41227      0.4121     0.41208     0.41219      0.4124     0.41268     0.41301     0.41337     0.41374      0.4141     0.41445     0.41477     0.41506     0.41531     0.41552      0.4157     0.41584     0.41594     0.41601     0.41604';'0.45805      0.4573     0.45583     0.45371     0.45103     0.44792      0.4445     0.44091     0.43725     0.43365     0.43019     0.42695     0.42398     0.42132     0.41899     0.41698      0.4153     0.41393     0.41285     0.41205     0.41148     0.41114     0.41098     0.41098     0.41112     0.41136     0.41167     0.41204     0.41243     0.41284     0.41324     0.41362     0.41397     0.41428     0.41456     0.41479     0.41499     0.41514     0.41525     0.41532     0.41536';'0.45659     0.45583     0.45435     0.45221     0.44952     0.44639     0.44295     0.43931     0.43561     0.43196     0.42845     0.42514     0.42211     0.41938     0.41697      0.4149     0.41316     0.41174     0.41063      0.4098     0.40923     0.40889     0.40876      0.4088     0.40899     0.40929     0.40968     0.41012     0.41059     0.41107     0.41155     0.41199      0.4124     0.41277     0.41309     0.41337     0.41359     0.41376     0.41389     0.41398     0.41402';'0.45447     0.45371     0.45221     0.45006     0.44735     0.44418     0.44069       0.437     0.43324      0.4295      0.4259      0.4225     0.41936     0.41652     0.41401     0.41183        0.41      0.4085     0.40733     0.40646     0.40588     0.40556     0.40546     0.40557     0.40584     0.40624     0.40674      0.4073     0.40789     0.40849     0.40907     0.40962     0.41013     0.41058     0.41097      0.4113     0.41157     0.41178     0.41194     0.41204     0.41209';' 0.4518     0.45103     0.44952     0.44735      0.4446     0.44138     0.43783     0.43406      0.4302     0.42636     0.42263     0.41909      0.4158     0.41281     0.41014     0.40782     0.40586     0.40425     0.40299     0.40207     0.40148     0.40117     0.40114     0.40133     0.40172     0.40226     0.40291     0.40363     0.40439     0.40515     0.40589     0.40658     0.40722     0.40778     0.40827     0.40868     0.40902     0.40928     0.40948      0.4096     0.40967';' 0.4487     0.44792     0.44639     0.44418     0.44138      0.4381     0.43446     0.43059     0.42661     0.42262     0.41872       0.415     0.41152     0.40832     0.40545     0.40294      0.4008     0.39904     0.39767     0.39668     0.39606     0.39579     0.39582     0.39614     0.39668      0.3974     0.39826      0.3992     0.40017     0.40115     0.40209     0.40297     0.40377     0.40448      0.4051     0.40561     0.40604     0.40636     0.40661     0.40677     0.40684';' 0.4453      0.4445     0.44295     0.44069     0.43783     0.43446     0.43072     0.42672     0.42257      0.4184     0.41429     0.41033      0.4066     0.40314     0.40001     0.39724     0.39488     0.39293     0.39141     0.39034     0.38969     0.38944     0.38957     0.39004     0.39078     0.39174     0.39286     0.39407     0.39532     0.39657     0.39776     0.39888     0.39989     0.40079     0.40156     0.40221     0.40273     0.40314     0.40344     0.40364     0.40374';'0.44172     0.44091     0.43931       0.437     0.43406     0.43059     0.42672     0.42255     0.41821     0.41381     0.40944     0.40519     0.40114     0.39735     0.39389     0.39082     0.38816     0.38597     0.38427     0.38307     0.38239     0.38218     0.38244     0.38309     0.38408     0.38534     0.38678     0.38834     0.38993     0.39151     0.39302     0.39442     0.39569     0.39681     0.39777     0.39857     0.39923     0.39973     0.40011     0.40035     0.40047';'0.43808     0.43725     0.43561     0.43324      0.4302     0.42661     0.42257     0.41821     0.41363     0.40895     0.40426     0.39966     0.39523     0.39105     0.38719     0.38372     0.38071     0.37821     0.37628     0.37494      0.3742     0.37405     0.37445     0.37534     0.37664     0.37827     0.38011     0.38208      0.3841     0.38607     0.38796      0.3897     0.39127     0.39265     0.39384     0.39483     0.39563     0.39625      0.3967       0.397     0.39715';' 0.4345     0.43365     0.43196      0.4295     0.42636     0.42262      0.4184     0.41381     0.40895     0.40394     0.39888     0.39386     0.38898     0.38431     0.37996     0.37602     0.37257      0.3697     0.36748     0.36596     0.36516     0.36508     0.36566     0.36684     0.36853     0.37059     0.37292     0.37539      0.3779     0.38036     0.38268     0.38482     0.38674     0.38843     0.38987     0.39107     0.39204     0.39279     0.39334      0.3937     0.39387';'0.43107     0.43019     0.42845      0.4259     0.42263     0.41872     0.41429     0.40944     0.40426     0.39888     0.39339     0.38788     0.38247     0.37724     0.37231     0.36779     0.36381     0.36049     0.35791     0.35617      0.3553     0.35529      0.3561     0.35763     0.35978     0.36238     0.36529     0.36836     0.37145     0.37445     0.37728     0.37988      0.3822     0.38423     0.38595     0.38739     0.38854     0.38944     0.39009     0.39052     0.39073';'0.42787     0.42695     0.42514      0.4225     0.41909       0.415     0.41033     0.40519     0.39966     0.39386     0.38788     0.38183      0.3758     0.36992     0.36431     0.35911     0.35449     0.35061      0.3476     0.34558     0.34462      0.3447     0.34579     0.34776     0.35047     0.35372     0.35732     0.36108     0.36484     0.36846     0.37186     0.37496     0.37773     0.38013     0.38217     0.38386     0.38522     0.38627     0.38704     0.38754     0.38778';'0.42493     0.42398     0.42211     0.41936      0.4158     0.41152      0.4066     0.40114     0.39523     0.38898     0.38247      0.3758     0.36909     0.36246     0.35606     0.35006     0.34467      0.3401     0.33657     0.33422     0.33314     0.33334     0.33476     0.33727     0.34066     0.34469      0.3491     0.35365     0.35817     0.36249     0.36652     0.37017     0.37341     0.37621     0.37859     0.38055     0.38213     0.38334     0.38422      0.3848     0.38508';' 0.4223     0.42132     0.41938     0.41652     0.41281     0.40832     0.40314     0.39735     0.39105     0.38431     0.37724     0.36992     0.36246       0.355      0.3477     0.34075     0.33443     0.32902     0.32483     0.32208     0.32086      0.3212     0.32304      0.3262     0.33044      0.3354     0.34076     0.34622     0.35158     0.35666     0.36135     0.36559     0.36932     0.37254     0.37527     0.37751      0.3793     0.38069     0.38169     0.38234     0.38266';'   0.42     0.41899     0.41697     0.41401     0.41014     0.40545     0.40001     0.39389     0.38719     0.37996     0.37231     0.36431     0.35606      0.3477     0.33938     0.33133     0.32385     0.31738     0.31239     0.30915     0.30778      0.3083     0.31063      0.3146      0.3199     0.32601     0.33247     0.33894     0.34521     0.35109     0.35647      0.3613     0.36554     0.36918     0.37225     0.37477     0.37678     0.37833     0.37945     0.38018     0.38053';'0.41803     0.41698      0.4149     0.41183     0.40782     0.40294     0.39724     0.39082     0.38372     0.37602     0.36779     0.35911     0.35006     0.34075     0.33133     0.32199     0.31309     0.30519     0.29923     0.29543     0.29388      0.2946     0.29751     0.30248     0.30921     0.31673     0.32445     0.33203     0.33924     0.34592       0.352     0.35741     0.36214     0.36618     0.36958     0.37236     0.37458     0.37628     0.37752     0.37832     0.37871';'0.41638      0.4153     0.41316        0.41     0.40586      0.4008     0.39488     0.38816     0.38071     0.37257     0.36381     0.35449     0.34467     0.33443     0.32385     0.31309     0.30235     0.29225     0.28523     0.28086     0.27913     0.28007      0.2836     0.28967     0.29861     0.30791     0.31704     0.32574     0.33387     0.34133     0.34806     0.35401     0.35918     0.36359     0.36729     0.37031     0.37271     0.37456     0.37589     0.37675     0.37718';'0.41503     0.41393     0.41174      0.4085     0.40425     0.39904     0.39293     0.38597     0.37821      0.3697     0.36049     0.35061      0.3401     0.32902     0.31738     0.30519     0.29225      0.2827     0.27536     0.27067     0.26885     0.26993     0.27382     0.28027     0.28877     0.30013     0.31063     0.32037     0.32933     0.33747     0.34476     0.35117     0.35673     0.36146      0.3654     0.36863     0.37119     0.37315     0.37456     0.37548     0.37593';'0.41398     0.41285     0.41063     0.40733     0.40299     0.39767     0.39141     0.38427     0.37628     0.36748     0.35791      0.3476     0.33657     0.32483     0.31239     0.29923     0.28523     0.27536     0.26774     0.26285     0.26096     0.26213     0.26626     0.27301     0.28186     0.29425     0.30569     0.31622     0.32582     0.33449     0.34221     0.34898     0.35483      0.3598     0.36394     0.36731     0.36999     0.37204     0.37352     0.37448     0.37495';'0.41318     0.41205      0.4098     0.40646     0.40207     0.39668     0.39034     0.38307     0.37494     0.36596     0.35617     0.34558     0.33422     0.32208     0.30915     0.29543     0.28086     0.27067     0.26285     0.25783      0.2559     0.25713     0.26139     0.26836     0.27754      0.2905     0.30248     0.31349     0.32349     0.33249     0.34049     0.34749     0.35352     0.35864      0.3629     0.36637     0.36912     0.37123     0.37275     0.37373     0.37421';'0.41262     0.41148     0.40923     0.40588     0.40148     0.39606     0.38969     0.38239      0.3742     0.36516      0.3553     0.34462     0.33314     0.32086     0.30778     0.29388     0.27913     0.26885     0.26096      0.2559     0.25394     0.25519     0.25951     0.26655     0.27583     0.28897     0.30113     0.31229     0.32243     0.33155     0.33963     0.34671     0.35281     0.35798     0.36228     0.36579     0.36857     0.37069     0.37222     0.37321      0.3737';'0.41227     0.41114     0.40889     0.40556     0.40117     0.39579     0.38944     0.38218     0.37405     0.36508     0.35529      0.3447     0.33334      0.3212      0.3083      0.2946     0.28007     0.26993     0.26213     0.25713     0.25519     0.25642     0.26068     0.26763     0.27676     0.28968     0.30165     0.31264     0.32265     0.33165     0.33965     0.34665     0.35269     0.35781     0.36207     0.36554      0.3683      0.3704     0.37192      0.3729     0.37339';' 0.4121     0.41098     0.40876     0.40546     0.40114     0.39582     0.38957     0.38244     0.37445     0.36566      0.3561     0.34579     0.33476     0.32304     0.31063     0.29751      0.2836     0.27382     0.26626     0.26139     0.25951     0.26068     0.26479     0.27149     0.28026     0.29257     0.30397     0.31448     0.32408     0.33275     0.34047     0.34725     0.35311     0.35808     0.36223      0.3656     0.36829     0.37034     0.37182     0.37278     0.37325';'0.41208     0.41098      0.4088     0.40557     0.40133     0.39614     0.39004     0.38309     0.37534     0.36684     0.35763     0.34776     0.33727      0.3262      0.3146     0.30248     0.28967     0.28027     0.27301     0.26836     0.26655     0.26763     0.27149     0.27787     0.28623     0.29748     0.30792     0.31764      0.3266     0.33474     0.34203     0.34846     0.35402     0.35876     0.36271     0.36594      0.3685     0.37046     0.37188      0.3728     0.37325';'0.41219     0.41112     0.40899     0.40584     0.40172     0.39668     0.39078     0.38408     0.37664     0.36853     0.35978     0.35047     0.34066     0.33044      0.3199     0.30921     0.29861     0.28877     0.28186     0.27754     0.27583     0.27676     0.28026     0.28623     0.29492     0.30411     0.31318     0.32186        0.33     0.33746      0.3442     0.35016     0.35535     0.35977     0.36347      0.3665     0.36891     0.37075     0.37209     0.37295     0.37338';' 0.4124     0.41136     0.40929     0.40624     0.40226      0.3974     0.39174     0.38534     0.37827     0.37059     0.36238     0.35372     0.34469      0.3354     0.32601     0.31673     0.30791     0.30013     0.29425      0.2905     0.28897     0.28968     0.29257     0.29748     0.30411     0.31157     0.31926     0.32682     0.33403     0.34073     0.34683     0.35225     0.35699     0.36105     0.36445     0.36724     0.36946     0.37117      0.3724      0.3732      0.3736';'0.41268     0.41167     0.40968     0.40674     0.40291     0.39826     0.39286     0.38678     0.38011     0.37292     0.36529     0.35732      0.3491     0.34076     0.33247     0.32445     0.31704     0.31063     0.30569     0.30248     0.30113     0.30165     0.30397     0.30792     0.31318     0.31926      0.3257     0.33218     0.33846     0.34435     0.34976      0.3546     0.35885     0.36251     0.36558     0.36811     0.37013     0.37168      0.3728     0.37353     0.37389';'0.41301     0.41204     0.41012      0.4073     0.40363      0.3992     0.39407     0.38834     0.38208     0.37539     0.36836     0.36108     0.35365     0.34622     0.33894     0.33203     0.32574     0.32037     0.31622     0.31349     0.31229     0.31264     0.31448     0.31764     0.32186     0.32682     0.33218     0.33766     0.34303     0.34813     0.35285      0.3571     0.36085     0.36408     0.36681     0.36906     0.37086     0.37225     0.37325      0.3739     0.37422';'0.41337     0.41243     0.41059     0.40789     0.40439     0.40017     0.39532     0.38993      0.3841      0.3779     0.37145     0.36484     0.35817     0.35158     0.34521     0.33924     0.33387     0.32933     0.32582     0.32349     0.32243     0.32265     0.32408      0.3266        0.33     0.33403     0.33846     0.34303     0.34757     0.35191     0.35596     0.35963     0.36288      0.3657     0.36808     0.37005     0.37163     0.37285     0.37373     0.37431     0.37459';'0.41374     0.41284     0.41107     0.40849     0.40515     0.40115     0.39657     0.39151     0.38607     0.38036     0.37445     0.36846     0.36249     0.35666     0.35109     0.34592     0.34133     0.33747     0.33449     0.33249     0.33155     0.33165     0.33275     0.33474     0.33746     0.34073     0.34435     0.34813     0.35191     0.35556     0.35898      0.3621     0.36487     0.36729     0.36934     0.37104      0.3724     0.37345     0.37422     0.37472     0.37496';' 0.4141     0.41324     0.41155     0.40907     0.40589     0.40209     0.39776     0.39302     0.38796     0.38268     0.37728     0.37186     0.36652     0.36135     0.35647       0.352     0.34806     0.34476     0.34221     0.34049     0.33963     0.33965     0.34047     0.34203      0.3442     0.34683     0.34976     0.35285     0.35596     0.35898     0.36183     0.36444     0.36677     0.36881     0.37054     0.37198     0.37314     0.37404      0.3747     0.37512     0.37533';'0.41445     0.41362     0.41199     0.40962     0.40658     0.40297     0.39888     0.39442      0.3897     0.38482     0.37988     0.37496     0.37017     0.36559      0.3613     0.35741     0.35401     0.35117     0.34898     0.34749     0.34671     0.34665     0.34725     0.34846     0.35016     0.35225      0.3546      0.3571     0.35963      0.3621     0.36444     0.36659     0.36853     0.37022     0.37167     0.37287     0.37384      0.3746     0.37515      0.3755     0.37568';'0.41477     0.41397      0.4124     0.41013     0.40722     0.40377     0.39989     0.39569     0.39127     0.38674      0.3822     0.37773     0.37341     0.36932     0.36554     0.36214     0.35918     0.35673     0.35483     0.35352     0.35281     0.35269     0.35311     0.35402     0.35535     0.35699     0.35885     0.36085     0.36288     0.36487     0.36677     0.36853     0.37011     0.37149     0.37268     0.37368     0.37448      0.3751     0.37556     0.37586       0.376';'0.41506     0.41428     0.41277     0.41058     0.40778     0.40448     0.40079     0.39681     0.39265     0.38843     0.38423     0.38013     0.37621     0.37254     0.36918     0.36618     0.36359     0.36146      0.3598     0.35864     0.35798     0.35781     0.35808     0.35876     0.35977     0.36105     0.36251     0.36408      0.3657     0.36729     0.36881     0.37022     0.37149     0.37262     0.37358     0.37439     0.37505     0.37556     0.37593     0.37617     0.37629';'0.41531     0.41456     0.41309     0.41097     0.40827      0.4051     0.40156     0.39777     0.39384     0.38987     0.38595     0.38217     0.37859     0.37527     0.37225     0.36958     0.36729      0.3654     0.36394      0.3629     0.36228     0.36207     0.36223     0.36271     0.36347     0.36445     0.36558     0.36681     0.36808     0.36934     0.37054     0.37167     0.37268     0.37358     0.37436     0.37501     0.37554     0.37595     0.37625     0.37645     0.37655';'0.41552     0.41479     0.41337      0.4113     0.40868     0.40561     0.40221     0.39857     0.39483     0.39107     0.38739     0.38386     0.38055     0.37751     0.37477     0.37236     0.37031     0.36863     0.36731     0.36637     0.36579     0.36554      0.3656     0.36594      0.3665     0.36724     0.36811     0.36906     0.37005     0.37104     0.37198     0.37287     0.37368     0.37439     0.37501     0.37553     0.37595     0.37628     0.37652     0.37668     0.37676';' 0.4157     0.41499     0.41359     0.41157     0.40902     0.40604     0.40273     0.39923     0.39563     0.39204     0.38854     0.38522     0.38213      0.3793     0.37678     0.37458     0.37271     0.37119     0.36999     0.36912     0.36857      0.3683     0.36829      0.3685     0.36891     0.36946     0.37013     0.37086     0.37163      0.3724     0.37314     0.37384     0.37448     0.37505     0.37554     0.37595     0.37629     0.37655     0.37675     0.37687     0.37694';'0.41584     0.41514     0.41376     0.41178     0.40928     0.40636     0.40314     0.39973     0.39625     0.39279     0.38944     0.38627     0.38334     0.38069     0.37833     0.37628     0.37456     0.37315     0.37204     0.37123     0.37069      0.3704     0.37034     0.37046     0.37075     0.37117     0.37168     0.37225     0.37285     0.37345     0.37404      0.3746      0.3751     0.37556     0.37595     0.37628     0.37655     0.37677     0.37692     0.37703     0.37708';'0.41594     0.41525     0.41389     0.41194     0.40948     0.40661     0.40344     0.40011      0.3967     0.39334     0.39009     0.38704     0.38422     0.38169     0.37945     0.37752     0.37589     0.37456     0.37352     0.37275     0.37222     0.37192     0.37182     0.37188     0.37209      0.3724      0.3728     0.37325     0.37373     0.37422      0.3747     0.37515     0.37556     0.37593     0.37625     0.37652     0.37675     0.37692     0.37705     0.37714     0.37718';'0.41601     0.41532     0.41398     0.41204      0.4096     0.40677     0.40364     0.40035       0.397      0.3937     0.39052     0.38754      0.3848     0.38234     0.38018     0.37832     0.37675     0.37548     0.37448     0.37373     0.37321      0.3729     0.37278      0.3728     0.37295      0.3732     0.37353      0.3739     0.37431     0.37472     0.37512      0.3755     0.37586     0.37617     0.37645     0.37668     0.37687     0.37703     0.37714     0.37721     0.37725';'0.41604     0.41536     0.41402     0.41209     0.40967     0.40684     0.40374     0.40047     0.39715     0.39387     0.39073     0.38778     0.38508     0.38266     0.38053     0.37871     0.37718     0.37593     0.37495     0.37421      0.3737     0.37339     0.37325     0.37325     0.37338      0.3736     0.37389     0.37422     0.37459     0.37496     0.37533     0.37568       0.376     0.37629     0.37655     0.37676     0.37694     0.37708     0.37718     0.37725     0.37728'];
finalTemps = str2num(finalTemps);
global framerate
framerate = 5000;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.5;
global list
list = '2.14158      4.28316      6.42475      8.56633      10.7079      12.8495      14.9911      17.1327      17.1327      17.1327      17.1327      17.1327      17.1327      17.1327      17.1327      17.1327      17.1327      17.1327      17.1327      17.1327';
list = str2num(list);
global materialMatrix
materialMatrix = ['1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1'];
materialMatrix = str2num(materialMatrix);
global materials
materials = 2;
global precision
precision = 10;
global radiation
radiation = 0;
global roomTemp
roomTemp = 0;
global self_set
self_set = 0;
global specific_heat
specific_heat = 1900;
global specific_heat2
specific_heat2 = 4130;
global tempsList
tempsList = '0.048326    0.096324     0.14413     0.19179     0.23933     0.28677     0.33412     0.38139     0.38026      0.3794     0.37866     0.37802     0.37744     0.37692     0.37643     0.37599     0.37557     0.37518     0.37482     0.37447';
tempsList = str2num(tempsList);
global thermal_Conductivity
thermal_Conductivity = 0.33;
global thermal_Conductivity2
thermal_Conductivity2 = 0.5;
global timeOff
timeOff = 2000;
global timeOn
timeOn = 0;
global total_time
total_time = 5000;
global xdist
xdist = 0.2;
global ydist
ydist = 0.2;
global zdist
zdist = 0.2;