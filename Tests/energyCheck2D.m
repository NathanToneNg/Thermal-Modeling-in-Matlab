global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 6;
global borders
borders = 1;
global constant
constant = 0.00080972;
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
distribution = 5;
global distributionFrequency
distributionFrequency = 12;
global dt
dt = 0.05;
global elevFrequency
elevFrequency = 12;
global elevLocation
elevLocation = 1;
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
finalTemps = ['0.37243     0.37365     0.37608     0.37968      0.3844     0.39017     0.39693     0.40456     0.41298     0.42205     0.43166     0.44165     0.45188     0.46212     0.47199     0.48081     0.48807     0.49342     0.49636     0.49656     0.49425      0.4898     0.48367      0.4762     0.46766     0.45828     0.44828     0.43788     0.42729     0.41669     0.40628     0.39624     0.38672     0.37787     0.36982      0.3627      0.3566     0.35162     0.34782     0.34526     0.34397';'0.37237     0.37359     0.37601      0.3796     0.38431     0.39007     0.39681     0.40443     0.41282     0.42188     0.43147     0.44146     0.45174     0.46219     0.47259     0.48177     0.48927     0.49501     0.49823     0.49816     0.49551     0.49065     0.48426     0.47662     0.46797      0.4585     0.44844     0.43799     0.42735     0.41673      0.4063     0.39625     0.38672     0.37787     0.36983     0.36271     0.35662     0.35164     0.34785     0.34529       0.344';'0.37227     0.37348     0.37589     0.37946     0.38414     0.38988     0.39658     0.40416     0.41252     0.42153     0.43107     0.44103     0.45132     0.46201     0.47394     0.48381     0.49149      0.5026     0.50249     0.50143     0.49808      0.4922     0.48534     0.47741     0.46855     0.45892     0.44873     0.43818     0.42746     0.41679     0.40633     0.39625     0.38672     0.37787     0.36984     0.36273     0.35665     0.35168      0.3479     0.34534     0.34406';'0.37212     0.37332     0.37571     0.37925      0.3839     0.38959     0.39625     0.40377     0.41206     0.42101     0.43048     0.44033     0.45037     0.46029     0.48077     0.49216     0.50166     0.50877     0.51251     0.51211     0.50774     0.49387     0.48668     0.47846     0.46934      0.4595     0.44912     0.43841     0.42759     0.41684     0.40633     0.39624      0.3867     0.37786     0.36984     0.36275     0.35669     0.35174     0.34797     0.34542     0.34414';'0.37194     0.37313     0.37549       0.379      0.3836     0.38923     0.39582     0.40327     0.41148     0.42033     0.42971     0.43947     0.44945     0.45946     0.48254     0.49489     0.50512      0.5126     0.51656     0.51633      0.5116     0.49585     0.48824     0.47969     0.47028     0.46017     0.44955     0.43864     0.42768     0.41684     0.40628     0.39617     0.38664     0.37781     0.36982     0.36276     0.35672      0.3518     0.34805     0.34552     0.34424';'0.37174     0.37292     0.37525     0.37871     0.38325      0.3888      0.3953     0.40266     0.41077     0.41952     0.42879     0.43846     0.44839     0.45847     0.48242     0.49523     0.50593     0.51387     0.51829     0.51846     0.51387     0.49771     0.48987     0.48102     0.47132     0.46088     0.44994     0.43879     0.42766     0.41673     0.40614     0.39602     0.38651     0.37771     0.36976     0.36274     0.35675     0.35185     0.34813     0.34562     0.34436';'0.37156     0.37271     0.37501     0.37841     0.38287     0.38834     0.39473     0.40196     0.40994     0.41857     0.42771     0.43726     0.44708     0.45703     0.48039     0.49308     0.50392     0.51233     0.51749     0.51845     0.51461     0.49946     0.49157     0.48243     0.47242     0.46159     0.45021     0.43875     0.42745     0.41644     0.40584     0.39574     0.38627     0.37754     0.36964     0.36268     0.35674      0.3519     0.34821     0.34572     0.34447';'0.37141     0.37254     0.37479     0.37812     0.38249     0.38785     0.39411      0.4012     0.40903     0.41749     0.42647     0.43588     0.44556     0.45529     0.47629     0.48824     0.49879     0.50771     0.51401     0.51618     0.51373     0.50154     0.49355     0.48386     0.47364     0.46233     0.45017     0.43835     0.42693      0.4159     0.40533     0.39531     0.38592     0.37727     0.36945     0.36257      0.3567     0.35191     0.34827     0.34582     0.34458';'0.37133     0.37243     0.37463     0.37788     0.38215     0.38737     0.39348      0.4004     0.40803     0.41629     0.42508     0.43431     0.44394     0.45405     0.46532     0.47547     0.48426     0.49958     0.50385     0.50834     0.50874     0.50522     0.49969     0.48494     0.47521     0.46335     0.44941     0.43735     0.42596     0.41504     0.40459     0.39468     0.38541     0.37688     0.36918     0.36239     0.35661      0.3519     0.34831     0.34589     0.34468';'0.37135     0.37242     0.37455     0.37771     0.38186     0.38693     0.39287     0.39958     0.40699       0.415     0.42353     0.43247     0.44178     0.45141     0.46131     0.47074     0.47949     0.48778     0.49567     0.50714     0.50988     0.50829     0.50255     0.49316     0.48199      0.4691     0.44636     0.43544     0.42449     0.41383     0.40358     0.39385     0.38475     0.37637     0.36881     0.36215     0.35647     0.35184     0.34832     0.34595     0.34476';'0.37151     0.37255     0.37461     0.37767     0.38167     0.38658     0.39231     0.39879     0.40594     0.41365     0.42185     0.43042     0.43928     0.44832     0.45738     0.46615     0.47445     0.48225     0.48943     0.50368     0.50759     0.50698     0.50216     0.49371     0.48254     0.46918     0.44408     0.43333     0.42269     0.41231     0.40232     0.39282     0.38393     0.37574     0.36834     0.36183     0.35627     0.35175      0.3483     0.34598     0.34481';'0.37185     0.37285     0.37484     0.37778     0.38164     0.38635     0.39186     0.39808     0.40493     0.41231     0.42012     0.42826     0.43661     0.44505     0.45343     0.46154     0.46927     0.47653     0.48332     0.49813     0.50254     0.50253     0.49836     0.49058     0.47983     0.46663     0.44142      0.4309     0.42058     0.41052     0.40083     0.39161     0.38296     0.37499     0.36779     0.36144     0.35602     0.35161     0.34825     0.34598     0.34485';'0.37242     0.37338     0.37528      0.3781     0.38179      0.3863     0.39157      0.3975     0.40402     0.41103     0.41843     0.42609     0.43391     0.44175     0.44947     0.45691     0.46397     0.47058     0.47677     0.49071     0.49498     0.49512     0.49127     0.48417     0.47417      0.4618      0.4381     0.42807     0.41817     0.40849     0.39915     0.39023     0.38186     0.37414     0.36715     0.36099     0.35573     0.35143     0.34817     0.34597     0.34486';'0.37326     0.37417     0.37599     0.37868      0.3822     0.38649     0.39149     0.39712     0.40329     0.40991     0.41686     0.42403     0.43129     0.43852     0.44558     0.45232     0.45863     0.46442     0.46969     0.48165      0.4852     0.48519     0.48113     0.47486     0.46593     0.45494     0.43431     0.42493     0.41552     0.40627      0.3973     0.38873     0.38066      0.3732     0.36645     0.36048     0.35539     0.35123     0.34806     0.34593     0.34485';'0.37442     0.37529     0.37701     0.37956      0.3829     0.38696     0.39169       0.397     0.40281     0.40901      0.4155     0.42216     0.42887     0.43549     0.44188     0.44791     0.45341     0.45823     0.46211     0.46441     0.46576     0.46604     0.46779     0.45546     0.44857     0.44025     0.43077     0.42169     0.41273     0.40392     0.39535     0.38714     0.37939     0.37221      0.3657     0.35995     0.35502     0.35101     0.34794     0.34588     0.34484';'0.37595     0.37677      0.3784      0.3808     0.38395     0.38777     0.39222      0.3972     0.40263     0.40841     0.41443     0.42058     0.42673     0.43275     0.43849     0.44382     0.44857     0.45257     0.45559     0.45737     0.45785     0.45667     0.45271     0.44816     0.44206     0.43475     0.42661     0.41825     0.40983     0.40149     0.39334      0.3855     0.37808     0.37119     0.36493     0.35939     0.35465     0.35077     0.34782     0.34582     0.34482';'0.37789     0.37866     0.38019     0.38245      0.3854     0.38898     0.39314     0.39778     0.40283     0.40819     0.41374     0.41938     0.42497      0.4304     0.43552      0.4402     0.44427     0.44757     0.44992     0.45114     0.45108     0.44955     0.44633     0.44195     0.43638     0.42981      0.4225     0.41481     0.40695     0.39908     0.39135     0.38388     0.37679     0.37018     0.36418     0.35885     0.35428     0.35055      0.3477     0.34577      0.3448';'0.38028     0.38101     0.38244     0.38455      0.3873     0.39064      0.3945     0.39881     0.40347      0.4084     0.41349     0.41863     0.42369     0.42855     0.43308     0.43714     0.44059     0.44328     0.44508     0.44582     0.44541     0.44372     0.44073      0.4366     0.43144      0.4254     0.41869     0.41156      0.4042     0.39677     0.38944     0.38232     0.37554     0.36922     0.36345     0.35833     0.35394     0.35034     0.34759     0.34574      0.3448';'0.38317     0.38384     0.38517     0.38714     0.38969     0.39278     0.39635     0.40032     0.40461     0.40912     0.41375      0.4184     0.42294     0.42725     0.43122     0.43472     0.43761     0.43977     0.44108     0.44142     0.44072     0.43891     0.43599     0.43205     0.42719     0.42155     0.41529     0.40861     0.40167     0.39464     0.38766     0.38087     0.37439     0.36833     0.36279     0.35787     0.35364     0.35017     0.34752     0.34573     0.34483';'0.38659     0.38721     0.38844     0.39025     0.39261     0.39546     0.39874     0.40238     0.40629     0.41039     0.41458     0.41875     0.42279     0.42658     0.43002     0.43299     0.43536     0.43704     0.43792     0.43791     0.43695     0.43501      0.4321     0.42827     0.42362     0.41827     0.41235     0.40602     0.39943     0.39274     0.38608     0.37959     0.37337     0.36755     0.36222     0.35747     0.35339     0.35004     0.34748     0.34575     0.34488';'0.39055     0.39112     0.39226     0.39392     0.39608     0.39869     0.40169     0.40501     0.40856     0.41225     0.41601     0.41972     0.42328     0.42658     0.42952     0.43199     0.43388     0.43512      0.4356     0.43526     0.43406     0.43197     0.42902     0.42524     0.42073     0.41557      0.4099     0.40384     0.39754     0.39113     0.38474      0.3785     0.37251      0.3669     0.36176     0.35717     0.35322     0.34998     0.34749     0.34581     0.34497';'0.39508     0.39561     0.39664     0.39817     0.40014     0.40252     0.40524     0.40823     0.41143     0.41474     0.41808     0.42134     0.42444     0.42727     0.42974     0.43174     0.43319       0.434      0.4341     0.43345     0.43201     0.42976     0.42672     0.42294      0.4185     0.41347     0.40797     0.40211     0.39603     0.38984     0.38367     0.37763     0.37184     0.36641     0.36142     0.35696     0.35313     0.34997     0.34755     0.34591     0.34509';'0.40019     0.40067     0.40161     0.40299     0.40478     0.40693     0.40939     0.41208     0.41493     0.41787      0.4208     0.42365      0.4263     0.42868      0.4307     0.43225     0.43327     0.43369     0.43343     0.43247     0.43077     0.42834     0.42518     0.42136     0.41692     0.41196     0.40656     0.40084     0.39491     0.38889     0.38289     0.37701     0.37138     0.36608     0.36122     0.35687     0.35312     0.35003     0.34766     0.34605     0.34524';'0.40587      0.4063     0.40716     0.40841     0.41002     0.41195     0.41415     0.41654     0.41907     0.42165      0.4242     0.42663     0.42887     0.43082      0.4324     0.43353     0.43414     0.43417     0.43356     0.43229     0.43033     0.42769     0.42439     0.42047     0.41599     0.41103     0.40568     0.40003      0.3942     0.38829     0.38241     0.37665     0.37113     0.36594     0.36116     0.35689     0.35319     0.35015      0.3478     0.34622     0.34541';'0.41211      0.4125     0.41327     0.41439     0.41584     0.41756     0.41951     0.42162     0.42384     0.42607     0.42826     0.43031     0.43214     0.43368     0.43485     0.43557     0.43579     0.43544     0.43448     0.43289     0.43066     0.42778      0.4243     0.42024     0.41568     0.41067     0.40531     0.39969      0.3939     0.38805     0.38224     0.37656     0.37111     0.36598     0.36126     0.35702     0.35335     0.35032     0.34798     0.34639     0.34559';'0.41889     0.41924     0.41993     0.42093     0.42222     0.42374     0.42546     0.42731     0.42922     0.43113     0.43297     0.43465      0.4361     0.43725     0.43802     0.43835     0.43818     0.43746     0.43616     0.43424     0.43172     0.42859      0.4249     0.42067     0.41597     0.41087     0.40545      0.3998       0.394     0.38817     0.38238     0.37673     0.37131     0.36621      0.3615     0.35727     0.35359     0.35053     0.34817     0.34656     0.34574';'0.42618     0.42649      0.4271     0.42799     0.42913     0.43047     0.43197     0.43356      0.4352      0.4368      0.4383     0.43964     0.44072      0.4415     0.44189     0.44185      0.4413     0.44022     0.43856     0.43632     0.43349     0.43009     0.42614      0.4217     0.41683     0.41159     0.40606     0.40033     0.39449     0.38862     0.38281     0.37715     0.37173     0.36661     0.36189     0.35762     0.35389     0.35077     0.34834     0.34668     0.34584';'0.43393      0.4342     0.43474     0.43553     0.43653      0.4377     0.43899     0.44035     0.44172     0.44304     0.44423     0.44523     0.44598      0.4464     0.44643     0.44602     0.44511     0.44367     0.44166     0.43908     0.43593     0.43222       0.428     0.42332     0.41823      0.4128     0.40712     0.40127     0.39533     0.38939     0.38353     0.37782     0.37236      0.3672     0.36242     0.35808     0.35424       0.351     0.34847     0.34671     0.34583';'0.44207     0.44232      0.4428     0.44349     0.44436     0.44538     0.44648     0.44763     0.44875      0.4498      0.4507     0.45139     0.45181      0.4519      0.4516     0.45084     0.44958     0.44778     0.44542     0.44249       0.439     0.43497     0.43044     0.42547     0.42012     0.41447      0.4086     0.40258      0.3965     0.39045      0.3845     0.37872     0.37319     0.36796      0.3631     0.35864     0.35465     0.35121     0.34849     0.34659     0.34563';'0.45055     0.45077      0.4512     0.45181     0.45257     0.45344     0.45438     0.45533     0.45623     0.45702     0.45765     0.45806     0.45818     0.45796     0.45733     0.45625     0.45465     0.45251      0.4498     0.44651     0.44265     0.43826     0.43339      0.4281     0.42246     0.41654     0.41043     0.40421     0.39797     0.39177      0.3857     0.37982      0.3742     0.36889     0.36393     0.35935     0.35514     0.35134     0.34838      0.3462     0.34517';'0.45928     0.45948     0.45986     0.46041     0.46108     0.46183     0.46262     0.46338     0.46408     0.46464     0.46502     0.46516     0.46501      0.4645     0.46358     0.46219     0.46028     0.45781     0.45474     0.45108     0.44684     0.44207     0.43682     0.43117     0.42518     0.41896     0.41258     0.40612     0.39967     0.39331      0.3871      0.3811     0.37538     0.36998     0.36493     0.36024     0.35582     0.35127     0.34814     0.34413     0.34435';'0.46818     0.46836     0.46872     0.46921     0.46981     0.47046     0.47111     0.47172     0.47223     0.47258     0.47273     0.47263     0.47222     0.47146     0.47028     0.46862     0.46642     0.46363     0.46021     0.45617     0.45153     0.44634     0.44067      0.4346     0.42824     0.42166     0.41497     0.40825     0.40157     0.39501     0.38864     0.38251     0.37669      0.3712     0.36611     0.36142     0.35723     0.34918     0.34577     0.34377     0.34427';'0.47713     0.47731     0.47766     0.47812     0.47867     0.47924     0.47979     0.48027     0.48061     0.48077      0.4807     0.48037     0.47973     0.47875     0.47735     0.47546     0.47301     0.46993     0.46618     0.46173     0.45666     0.45101     0.44487     0.43834     0.43154     0.42458     0.41754     0.41052     0.40359     0.39682     0.39028     0.38401     0.37807     0.37251     0.36736     0.36265     0.35843     0.34967      0.3462     0.34444     0.34503';'0.48603     0.48623     0.48658     0.48705     0.48758      0.4881     0.48855     0.48894     0.48914      0.4891     0.48882     0.48828     0.48744     0.48627      0.4847     0.48265        0.48      0.4767     0.47262     0.46773     0.46218     0.45603     0.44937     0.44231     0.43501     0.42761     0.42021     0.41287     0.40567     0.39868     0.39195     0.38554      0.3795     0.37385     0.36865     0.36391      0.3597     0.35144     0.34805     0.34619     0.34664';'0.49475     0.49498     0.49539     0.49588     0.49646     0.49697     0.49726     0.49769     0.49774     0.49749     0.49701     0.49624     0.49521     0.49391     0.49225     0.49011     0.48735     0.48391     0.47959     0.47411     0.46806     0.46137     0.45409      0.4464     0.43854     0.43067     0.42287      0.4152     0.40773     0.40052     0.39361     0.38706      0.3809     0.37518     0.36992     0.36513      0.3608     0.35671     0.35364     0.34889     0.34902';'0.50314     0.50345     0.50397      0.5045     0.50524     0.50589     0.50561     0.50656     0.50637     0.50582     0.50515     0.50413      0.5029     0.50151     0.49988      0.4978     0.49494     0.49159     0.48732     0.48071     0.47423     0.46701     0.45901     0.45048     0.44199     0.43363     0.42543     0.41743      0.4097     0.40226     0.39518     0.38849     0.38224     0.37645     0.37115     0.36638     0.36214     0.35845     0.35554     0.35344     0.35202';'0.51098     0.51149     0.51231     0.51264     0.51384     0.51542     0.52146     0.51621     0.51498     0.51386     0.51321     0.51177     0.51027     0.50885     0.50746     0.50575     0.50251     0.49966     0.49687     0.49472     0.48073     0.47305     0.46416     0.45429     0.44517     0.43634     0.42777     0.41947     0.41149     0.40385     0.39661     0.38979     0.38345     0.37761      0.3723     0.36755      0.3634      0.3599     0.35716     0.35522     0.35414';'0.51798     0.51889      0.5208     0.52871      0.5321      0.5343     0.53488      0.5352      0.5336     0.53034      0.5215      0.5189     0.51698     0.51559     0.51475     0.51459     0.51783     0.51687     0.51336     0.50667     0.49863     0.48887     0.47758     0.45708     0.44783     0.43869      0.4298     0.42123     0.41302     0.40521     0.39783     0.39091     0.38449      0.3786     0.37328     0.36856     0.36448      0.3611     0.35847     0.35665      0.3557';'0.52366     0.52485     0.52734      0.5366      0.5408     0.54355     0.54472      0.5445      0.5424     0.53831     0.52793     0.52471     0.52247     0.52112     0.52063     0.52115     0.52537       0.525     0.52171      0.5155     0.50694     0.49623     0.48363     0.45998     0.45014     0.44062     0.43144     0.42264     0.41425     0.40629     0.39879     0.39179     0.38531     0.37939     0.37406     0.36936     0.36533     0.36201     0.35945     0.35771     0.35682';'0.52763     0.52901     0.53184     0.54213     0.54686     0.54999     0.55139     0.55096      0.5485     0.54387     0.53237     0.52877     0.52635       0.525     0.52472     0.52559     0.53065     0.53066     0.52758     0.52146      0.5126     0.50126     0.48775      0.4622     0.45186       0.442     0.43259     0.42363      0.4151     0.40704     0.39946      0.3924     0.38588     0.37994      0.3746     0.36991      0.3659     0.36262     0.36011     0.35841     0.35755';'0.52968     0.53114     0.53414     0.54497     0.54997     0.55329     0.55477     0.55427     0.55163     0.54672     0.53464     0.53087     0.52835       0.527     0.52682     0.52785     0.53336     0.53357     0.53059     0.52448     0.51546     0.50381     0.48985     0.46338     0.45277     0.44273      0.4332     0.42413     0.41554     0.40742     0.39981     0.39271     0.38617     0.38022     0.37488     0.37019      0.3662     0.36293     0.36044     0.35876     0.35791'];
finalTemps = str2num(finalTemps);
global framerate
framerate = 10000;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.3;
global list
list = '6.42847      6.42889      10.6823      14.9357      19.1892      23.4426      23.4426      23.4426      23.4426      23.4426      23.4426      23.4426      23.4426      23.4426      23.4426      23.4426      23.4426      23.4426      23.4426      23.4426';
list = str2num(list);
global materialMatrix
materialMatrix = ['1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  1  1  1  1  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  2  2  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  2  1';'1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  1  1  1  2  1  1  1  1  1  1  1  1  1  1  1  1  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1';'1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  2  2  2  2  2  2  2  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1'];
materialMatrix = str2num(materialMatrix);
global materials
materials = 3;
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
tempsList = '0.14477     0.13953      0.1729     0.21798     0.26972     0.32618     0.34931     0.36448     0.37584     0.38478     0.39202     0.39802     0.40304      0.4073     0.41094     0.41408     0.41679     0.41914     0.42118     0.42297';
tempsList = str2num(tempsList);
global thermal_Conductivity
thermal_Conductivity = 0.7;
global thermal_Conductivity2
thermal_Conductivity2 = 0.5;
global timeOff
timeOff = 3000;
global timeOn
timeOn = 1000;
global total_time
total_time = 10000;
global xdist
xdist = 0.2;
global ydist
ydist = 0.2;
global zdist
zdist = 0.2;

diffAmount = (list(2:end) - list(1:end-1))./list(1:end-1)