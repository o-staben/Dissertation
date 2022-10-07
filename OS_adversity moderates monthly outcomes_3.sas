ods listing;
ods html close;
ods graphics off;

TITLE1 'OS';
OPTIONS linesize = 180;
LIBNAME os  'C:\Users\omar0\Dropbox (ASU)\GSA 2021';
RUN;


DATA combined; SET os.combinedlongdata_22221;
RUN;

PROC SORT DATA = combined;
	BY id2;
RUN;




PROC MEANS DATA = combined;
	VAR personal_pm personal_sev_pm familyfriend_pm familyfriend_sev_pm  bereavement_pm bereavement_sev_pm;
RUN;
* 
                                                                                The MEANS Procedure

          Variable               Label                                                                   N            Mean         Std Dev         Minimum         Maximum
          ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
          Personal_PM            PM.  Sum of Personal Illness Injury from Monthly                     6956       0.1748131       0.5153890               0       7.0000000
          Personal_Sev_PM        PM. Average Severity of Personal Illness Injury from Monthly          869       2.8780810       1.1585077       1.0000000       5.0000000
          FamilyFriend_PM        PM.  Sum of Family Friend Illness Injury from Monthly                6961       0.3374515       0.9100592               0      25.0000000
          FamilyFriend_Sev_PM    PM. Average Severity of Family Friend Illness Injury from Monthly    1346       3.2516260       1.1811849       1.0000000       5.0000000
          Bereavement_PM         PM. Sum of Bereavement from Monthly                                  6957       0.1315222       0.3692962               0       3.0000000
          Bereavement_Sev_PM     PM. Average Severity of Bereavement from Monthly                      780       3.1059219       1.1859081       1.0000000       5.0000000



;


*Subjective neighborhood**;
data combined; set combined;

NeighborCoh = mean (NeighborCoh_P);

NeighborDis = mean(NeighborDis_P);
run;


**Objective indicators from ACS**;

data combined; set combined;

Percrent = mean(PercentRentOcc);
Unemploy = mean(UnemploymentRate);
percwhite = mean(Percentwhite);
green = mean(Percentgreen);
incomeinq = mean(GINI);
medincome = mean (medianincome);
medage = mean (medage);

run;

proc corr data = combined;
var green percwhite unemploy incomeinq percrent medincome medage;
run;
*  Pearson Correlation Coefficients, N = 6762
                                                                             Prob > |r| under H0: Rho=0

                                                     green      percwhite      Unemploy      incomeinq      Percrent      medincome        Medage

                                   green           1.00000        0.07872      -0.08705        0.20846       0.04235        0.03962      -0.02622
                                                                   <.0001        <.0001         <.0001        0.0005         0.0011        0.0311

                                   percwhite       0.07872        1.00000      -0.60044        0.13336      -0.61235        0.55872       0.72366
                                                    <.0001                       <.0001         <.0001        <.0001         <.0001        <.0001

                                   Unemploy       -0.08705       -0.60044       1.00000        0.09748       0.36164       -0.69214      -0.23863
                                                    <.0001         <.0001                       <.0001        <.0001         <.0001        <.0001

                                   incomeinq       0.20846        0.13336       0.09748        1.00000       0.30671       -0.24756       0.32186
                                                    <.0001         <.0001        <.0001                       <.0001         <.0001        <.0001

                                   Percrent        0.04235       -0.61235       0.36164        0.30671       1.00000       -0.69680      -0.58230
                                                    0.0005         <.0001        <.0001         <.0001                       <.0001        <.0001

                                   medincome       0.03962        0.55872      -0.69214       -0.24756      -0.69680        1.00000       0.24059
                                                    0.0011         <.0001        <.0001         <.0001        <.0001                       <.0001

                                   Medage         -0.02622        0.72366      -0.23863        0.32186      -0.58230        0.24059       1.00000
                                   Medage           0.0311         <.0001        <.0001         <.0001        <.0001         <.0001


;

DATA combined; SET combined;
IF id2 = . THEN id2 = .;
RUN;

data combined; set combined;

id_p = id2;

run;



/*
BASELINE DATA
*/

*Inputting SPSS data file - monthly;
PROC IMPORT DATAFILE= "C:\Users\omar0\Dropbox (ASU)\GSA 2021\PBL_data.sav"
			OUT=baseline
            DBMS=SAV
			REPLACE; *Note that REPLACE does not appear in blue;
RUN;   

DATA baseline; SET baseline;
format _all_;
RUN;

PROC CONTENTS DATA = baseline;
RUN;

DATA baseline; SET baseline;
IF gender_p = 99 THEN gender_p = .;
RUN;

PROC MEANS DATA = baseline;
	VAR age_p gender_p college_p white_p married_p children_p income_p incomer_p working_p housesize_p ParentCareGive_p totaladversity_p  ;
RUN;
*  The MEANS Procedure

 Variable            Label                                                                                                        N            Mean         Std Dev         Minimum
 ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
 Age_P               P. You are _______ years old today?                                                                        361      58.0332410       4.3892549      50.0000000
 Gender_P            P. What gender do you identify with?                                                                       361       0.5429363       0.4988445               0
 College_P           P. College                                                                                                 362       0.6823204       0.4662185               0
 White_P             P. White                                                                                                   357       0.9215686       0.2692265               0
 Married_P           P. Married                                                                                                 362       0.7320442       0.4435074               0
 Children_P          P. Number of Children                                                                                      362       1.8121547       1.4271085               0
 Income_P            P. What was your total household income from all sources last year (January to December), before taxes?    350        88122.88        59004.24               0
 IncomeR_P           P. Income recoded into 4 groups                                                                            350       2.4714286       1.0748683       1.0000000
 Working_P           P. Are you currently employed?                                                                             358       0.6284916       0.4838842               0
 HouseSize_P         P. How many people are living or staying at this address?                                                  362       2.2292818       0.9761273       1.0000000
 ParentCareGive_P    P. Are you caring for one of your parents or in-laws?                                                      362       0.0801105       0.2718399               0
 TotalAdversity_P    P. Total Number of Life Events from Baseline                                                               359      19.8997214       8.2483095               0
 ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ

                    Variable            Label                                                                                                           Maximum
                    ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                    Age_P               P. You are _______ years old today?                                                                          65.0000000
                    Gender_P            P. What gender do you identify with?                                                                          1.0000000
                    College_P           P. College                                                                                                    1.0000000
                    White_P             P. White                                                                                                      1.0000000
                    Married_P           P. Married                                                                                                    1.0000000
                    Children_P          P. Number of Children                                                                                         8.0000000
                    Income_P            P. What was your total household income from all sources last year (January to December), before taxes?       425000.00
                    IncomeR_P           P. Income recoded into 4 groups                                                                               4.0000000
                    Working_P           P. Are you currently employed?                                                                                1.0000000
                    HouseSize_P         P. How many people are living or staying at this address?                                                     7.0000000
                    ParentCareGive_P    P. Are you caring for one of your parents or in-laws?                                                         1.0000000
                    TotalAdversity_P    P. Total Number of Life Events from Baseline                                                                 49.0000000
                                                                                            360       0.4527778;

DATA baseline; SET baseline;
IF edu_self_p = 2 THEN eduyears = 12;
IF edu_self_p = 3 THEN eduyears = 14;
IF edu_self_p = 4 THEN eduyears = 14;
IF edu_self_p = 5 THEN eduyears = 16;
IF edu_self_p = 6 THEN eduyears = 18;
IF edu_self_p = 7 THEN eduyears = 20;
IF edu_self_p = 8 THEN eduyears = 20;

RUN;

PROC MEANS DATA = baseline;
	VAR eduyears;
RUN;
*       The MEANS Procedure

                                                                           Analysis Variable : eduyears

                                                          N            Mean         Std Dev         Minimum         Maximum
                                                        ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                                                        362      16.1160221       1.9460359      12.0000000      20.0000000
                                                        ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
;


PROC MEANS DATA = baseline;
	VAR age_p gender_p college_p eduyears white_p married_p children_p income_p incomer_p working_p housesize_p;
RUN;
*
  
                                                                                The MEANS Procedure

 Variable     Label                                                                                                      N          Mean       Std Dev       Minimum       Maximum
 ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
 Age_P        P. You are _______ years old today?                                                                      361    58.0332410     4.3892549    50.0000000    65.0000000
 Gender_P     P. What gender do you identify with?                                                                     361     0.5429363     0.4988445             0     1.0000000
 College_P    P. College                                                                                               362     0.6823204     0.4662185             0     1.0000000
 eduyears                                                                                                              362    16.1160221     1.9460359    12.0000000    20.0000000
 White_P      P. White                                                                                                 357     0.9215686     0.2692265             0     1.0000000
 Married_P    P. Married                                                                                               362     0.7320442     0.4435074             0     1.0000000
 Children_P   P. Number of Children                                                                                    362     1.8121547     1.4271085             0     8.0000000
 Income_P     P. What was your total household income from all sources last year (January to December), before taxes?  350      88122.88      59004.24             0     425000.00
 IncomeR_P    P. Income recoded into 4 groups                                                                          350     2.4714286     1.0748683     1.0000000     4.0000000
 Working_P    P. Are you currently employed?                                                                           358     0.6284916     0.4838842             0     1.0000000
 HouseSize_P  P. How many people are living or staying at this address?                                                362     2.2292818     0.9761273     1.0000000     7.0000000
 ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
;
PROC CORR DATA = baseline;
	VAR pos;
RUN;


PROC CORR DATA = baseline;
	VAR gender_p college_p eduyears income_p caregivingroles totalroles healthlimitations_p healthsymptoms_p healthconditions_p;
RUN;


DATA baseline2; SET baseline;
KEEP id_p age_p gender_p college_p eduyears white_p married_p children_p income_p incomer_p working_p housesize_p ParentCareGive_p  healthlimitations_p healthsymptoms_p healthconditions_p 
	 totaladversity_p posfamsup_p negfamsup_p; 
RUN;

PROC SORT DATA = baseline2;
	BY id_p;
RUN;

DATA lagtime10; SET combined;
RUN;

PROC SORT DATA = lagtime10;
	BY id_p;
RUN;

DATA lagtime;
MERGE lagtime10 baseline2;
	BY id_p;
RUN;


PROC MEANS DATA = lagtime;
	VAR personal_pm familyfriend_pm violence_pm bereavement_pm socialenv_pm relationship_pm naturaldisaster_pm totaladversity_pm
		lifesat_p depression_p anxiety_p compassion_p generative_p gratitude_p PerspTaking_p totaladversity_p age_p gender_p eduyears white_p married_p working_p  healthconditions_p healthlimitations_p
NeighborCoh NeighborDis percrent incomeinq unemploy percwhite green pa_p na_p ;
RUN;
*The MEANS Procedure

                 The MEANS Procedure

                Variable               Label                                                       N            Mean         Std Dev         Minimum         Maximum
                ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                Personal_PM            PM.  Sum of Personal Illness Injury from Monthly         6956       0.1748131       0.5153890               0       7.0000000
                FamilyFriend_PM        PM.  Sum of Family Friend Illness Injury from Monthly    6961       0.3374515       0.9100592               0      25.0000000
                Violence_PM            PM. Sum of Violence from Monthly                         6955       0.0146657       0.1390754               0       4.0000000
                Bereavement_PM         PM. Sum of Bereavement from Monthly                      6957       0.1315222       0.3692962               0       3.0000000
                SocialEnv_PM           PM. Sum of Social Envirionmental from Monthly            6962       0.8483194       1.3360626               0      22.0000000
                Relationship_PM        PM. Sum of Relationship Stress from Monthly              6960       0.3807471       0.7671046               0       7.0000000
                NaturalDisaster_PM     PM. Sum of Natural Disasters from Monthly                6954       0.0097785       0.1107842               0       3.0000000
                TotalAdversity_PM      PM. Total Number of Life Events from Monthly             6963       2.1197760       2.7196421               0      32.0000000
                LifeSat_P              P. Life Satisfaction                                     6952       7.5992520       2.1661498               0      10.0000000
                Depression_P           P. Depression                                            6976       7.6793291       6.8551805               0      30.0000000
                Anxiety_P              P. Anxiety                                               6967       1.5788003       0.4301600       1.0000000       4.0000000
                Compassion_P           P. Compassionate love for close others                   7007       5.7705913       1.0911685       1.0000000       7.0000000
                Generative_P           P. Generativity                                          6985       2.0854833       0.5823410               0       3.0000000
                Gratitude_P            P. Gratitude                                             7029       5.9746550       1.0923460       1.0000000       7.0000000
                PerspTaking_P          P. Perspective Taking                                    7028       4.0124621       0.6099484       1.0000000       5.0000000
                TotalAdversity_P       P. Total Number of Life Events from Baseline             7357      19.8160935       8.2229848               0      49.0000000
                Age_P                  P. You are _______ years old today?                      7361      58.1467192       4.3530902      50.0000000      65.0000000
                Gender_P               P. What gender do you identify with?                     7380       0.5513550       0.4973894               0       1.0000000
                eduyears                                                                         362      16.1160221       1.9460359      12.0000000      20.0000000
                White_P                P. White                                                 7279       0.9171590       0.2756608               0       1.0000000
                Married_P              P. Married                                               7383       0.7243668       0.4468631               0       1.0000000
                Working_P              P. Are you currently employed?                           7313       0.6219062       0.4849444               0       1.0000000
                HealthConditions_P     P. Sum of Health Conditions                              7331       2.0703860       1.8859602               0      10.0000000
                HealthLimitations_P    P. Health Limitations                                    7381       1.2617155       0.3914766       1.0000000       2.9000000
                NeighborCoh                                                                     7012       3.4963206       0.9352924       1.0000000       5.0000000
                NeighborDis                                                                     7012       1.4134511       0.4734263       1.0000000       3.4000000
                Percrent                                                                        6762      38.1313607      15.6857259       6.6733871      79.4677668
                incomeinq                                                                       6762       0.4339260       0.0527787       0.3313000       0.5621000
                Unemploy                                                                        6762       5.5410234       2.0471408               0      22.9000000
                percwhite                                                                       6762      64.7065971      16.8848575      11.6645106      97.6571243
                green                                                                           6762       0.1388241       0.6754474               0       6.4149775
                ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ

;



*Correlations*;


proc corr data = lagtime;
var green percwhite unemploy incomeinq percrent medincome medage;
run;


DATA lagtime; SET lagtime;
totaladversityc = totaladversity_p - 19.8160935;
womanc = gender_p - 0.5513550;
educ = eduyears - 16.1160221;
healthconditionsc = healthconditions_p - 2.0703860;
healthlimitationsc = healthlimitations_p - 1.2617155;

agec = age_p -  58.1467192;

incomec = incomeinq - 0.4339260;

rentc = percrent - 38.1313607;

unemployc = unemploy -  5.5410234 ;


percwhitec = percwhite - 64.7065971;

greenc = green - 0.1388241 ;

cohesionc = NeighborCoh - 3.4963206  ;

disorderc = NeighborDis - 1.4134511 ;



IF totaladversity_pm = 0 THEN adversitymonthly = 0;
IF totaladversity_pm GT 0 THEN adversitymonthly = 1;


RUN;

PROC SORT DATA = lagtime;
	BY id_p;
RUN;

DATA lagtime; SET lagtime;
count + 1;
by id_p;
if first.id_p THEN count = 1;
RUN;
DATA wave1; SET lagtime;
IF count NE 1 THEN DELETE;
RUN;

DATA wave1; SET wave1;
adversitylagtime1 = adversitylagtime;

RUN;

DATA wave1; SET wave1;
KEEP id_p adversitylagtime1;
RUN;



DATA wave2; SET lagtime;
IF count NE 2 THEN DELETE;
RUN;

DATA wave2; SET wave2;
adversitylagtime2 = adversitylagtime;

RUN;

DATA wave2; SET wave2;
KEEP id_p adversitylagtime2;
RUN;



DATA wave3; SET lagtime;
IF count NE 3 THEN DELETE;
RUN;

DATA wave3; SET wave3;
adversitylagtime3 = adversitylagtime;

RUN;

DATA wave3; SET wave3;
KEEP id_p adversitylagtime3;
RUN;


DATA wave4; SET lagtime;
IF count NE 4 THEN DELETE;
RUN;

DATA wave4; SET wave4;
adversitylagtime4 = adversitylagtime;

RUN;

DATA wave4; SET wave4;
KEEP id_p adversitylagtime4;
RUN;


DATA wave5; SET lagtime;
IF count NE 5 THEN DELETE;
RUN;

DATA wave5; SET wave5;
adversitylagtime5 = adversitylagtime;

RUN;

DATA wave5; SET wave5;
KEEP id_p adversitylagtime5;
RUN;


DATA wave6; SET lagtime;
IF count NE 6 THEN DELETE;
RUN;

DATA wave6; SET wave6;
adversitylagtime6 = adversitylagtime;

RUN;

DATA wave6; SET wave6;
KEEP id_p adversitylagtime6;
RUN;


DATA wave7; SET lagtime;
IF count NE 7 THEN DELETE;
RUN;

DATA wave7; SET wave7;
adversitylagtime7 = adversitylagtime;

RUN;

DATA wave7; SET wave7;
KEEP id_p adversitylagtime7;
RUN;


DATA wave8; SET lagtime;
IF count NE 8 THEN DELETE;
RUN;

DATA wave8; SET wave8;
adversitylagtime8 = adversitylagtime;

RUN;

DATA wave8; SET wave8;
KEEP id_p adversitylagtime8 ;
RUN;


DATA wave9; SET lagtime;
IF count NE 9 THEN DELETE;
RUN;

DATA wave9; SET wave9;
adversitylagtime9 = adversitylagtime;

RUN;

DATA wave9; SET wave9;
KEEP id_p adversitylagtime9;
RUN;


DATA wave10; SET lagtime;
IF count NE 10 THEN DELETE;
RUN;

DATA wave10; SET wave10;
adversitylagtime10 = adversitylagtime;

RUN;

DATA wave10; SET wave10;
KEEP id_p adversitylagtime10;
RUN;



DATA wave11; SET lagtime;
IF count NE 11 THEN DELETE;
RUN;

DATA wave11; SET wave11;
adversitylagtime11 = adversitylagtime;

RUN;

DATA wave11; SET wave11;
KEEP id_p adversitylagtime11;
RUN;



DATA wave12; SET lagtime;
IF count NE 12 THEN DELETE;
RUN;

DATA wave12; SET wave12;
adversitylagtime12 = adversitylagtime;


DATA wave12; SET wave12;
KEEP id_p adversitylagtime12;
RUN;



PROC SORT DATA = wave1;
	BY id_p;
RUN;

PROC SORT DATA = wave2;
	BY id_p;
RUN;

PROC SORT DATA = wave3;
	BY id_p;
RUN;

PROC SORT DATA = wave4;
	BY id_p;
RUN;

PROC SORT DATA = wave5;
	BY id_p;
RUN;

PROC SORT DATA = wave6;
	BY id_p;
RUN;

PROC SORT DATA = wave7;
	BY id_p;
RUN;

PROC SORT DATA = wave8;
	BY id_p;
RUN;

PROC SORT DATA = wave9;
	BY id_p;
RUN;

PROC SORT DATA = wave10;
	BY id_p;
RUN;

PROC SORT DATA = wave11;
	BY id_p;
RUN;

PROC SORT DATA = wave12;
	BY id_p;
RUN;


proc freq data = lagtime;
 tables adversitymonthly;
 run;


PROC MEANS DATA = lagtime;
	VAR adversitymonthly ;
RUN;
*  The MEANS Procedure

                                                                        Analysis Variable : adversitymonthly

                                                           N            Mean         Std Dev         Minimum         Maximum
                                                        ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ
                                                        6963       0.6737039       0.4688908               0       1.0000000
                                                        ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ

;


proc corr data = lagtime;
var incomeinq green percrent unemploy NeighborDis NeighborCoh pa_p na_p depression_p  lifesat_p anxiety_p gender_p age_p;
run;
**   Simple Statistics

                       Variable               N          Mean       Std Dev           Sum       Minimum       Maximum    Label

                       incomeinq           6762       0.43393       0.05278          2934       0.33130       0.56210
                       green               6762       0.13882       0.67545     938.72860             0       6.41498
                       Percrent            6762      38.13136      15.68573        257844       6.67339      79.46777
                       Unemploy            6762       5.54102       2.04714         37468             0      22.90000
                       NeighborDis         7012       1.41345       0.47343          9911       1.00000       3.40000
                       NeighborCoh         7012       3.49632       0.93529         24516       1.00000       5.00000
                       PA_P                6966       4.01628       1.18678         27977       1.00000       6.00000    P. Positive Affect
                       NA_P                6966       2.22199       1.06572         15478       1.00000       6.00000    P. Negative Affect
                       Depression_P        6976       7.67933       6.85518         53571             0      30.00000    P. Depression
                       LifeSat_P           6952       7.59925       2.16615         52830             0      10.00000    P. Life Satisfaction
                       Anxiety_P           6967       1.57880       0.43016         11000       1.00000       4.00000    P. Anxiety
                       Gender_P            7393       0.55160       0.49736          4078             0       1.00000    P. What gender do you identify with?
                       Age_P               7374      58.14890       4.35260        428790      50.00000      65.00000    P. You are _______ years old today?


                                                                         Pearson Correlation Coefficients
                                                                            Prob > |r| under H0: Rho=0
                                                                              Number of Observations

                                                                                   Neighbor  Neighbor                      Depression_  LifeSat_
                                          incomeinq     green  Percrent  Unemploy       Dis       Coh      PA_P      NA_P            P         P  Anxiety_P  Gender_P     Age_P

    incomeinq                               1.00000   0.20846   0.30671   0.09748   0.07752   0.06255   0.00206  -0.00764      0.00628  -0.01200   -0.01665   0.01951   0.04357
                                                       <.0001    <.0001    <.0001    <.0001    <.0001    0.8658    0.5322       0.6070    0.3269     0.1731    0.1088    0.0003
                                               6762      6762      6762      6762      6761      6761      6697      6697         6704      6682       6696      6760      6741

    green                                   0.20846   1.00000   0.04235  -0.08705  -0.02598   0.05917  -0.03453   0.04212      0.05685  -0.00803    0.07436   0.02044  -0.08548
                                             <.0001              0.0005    <.0001    0.0327    <.0001    0.0047    0.0006       <.0001    0.5119     <.0001    0.0928    <.0001
                                               6762      6762      6762      6762      6761      6761      6697      6697         6704      6682       6696      6760      6741

    Percrent                                0.30671   0.04235   1.00000   0.36164   0.40647  -0.10593  -0.05886   0.05569      0.09396  -0.08876    0.08137  -0.01630  -0.02092
                                             <.0001    0.0005              <.0001    <.0001    <.0001    <.0001    <.0001       <.0001    <.0001     <.0001    0.1801    0.0859
                                               6762      6762      6762      6762      6761      6761      6697      6697         6704      6682       6696      6760      6741

    Unemploy                                0.09748  -0.08705   0.36164   1.00000   0.36729  -0.10379  -0.05804   0.05041      0.07359  -0.06014    0.06319  -0.07348   0.03338
                                             <.0001    <.0001    <.0001              <.0001    <.0001    <.0001    <.0001       <.0001    <.0001     <.0001    <.0001    0.0061
                                               6762      6762      6762      6762      6761      6761      6697      6697         6704      6682       6696      6760      6741

    NeighborDis                             0.07752  -0.02598   0.40647   0.36729   1.00000  -0.41987  -0.21505   0.20298      0.24873  -0.20543    0.21772  -0.04792  -0.04876
                                             <.0001    0.0327    <.0001    <.0001              <.0001    <.0001    <.0001       <.0001    <.0001     <.0001    <.0001    <.0001
                                               6761      6761      6761      6761      7012      7012      6947      6947         6954      6931       6946      7010      6991

                                                                                         OS                                                      11:09 Tuesday, November 9, 2021  62

                                                                                 The CORR Procedure

                                                                         Pearson Correlation Coefficients
                                                                            Prob > |r| under H0: Rho=0
                                                                              Number of Observations

                                                                                   Neighbor  Neighbor                      Depression_  LifeSat_
                                          incomeinq     green  Percrent  Unemploy       Dis       Coh      PA_P      NA_P            P         P  Anxiety_P  Gender_P     Age_P

    NeighborCoh                             0.06255   0.05917  -0.10593  -0.10379  -0.41987   1.00000   0.20937  -0.18694     -0.22292   0.26170   -0.16703   0.20135   0.10407
                                             <.0001    <.0001    <.0001    <.0001    <.0001              <.0001    <.0001       <.0001    <.0001     <.0001    <.0001    <.0001
                                               6761      6761      6761      6761      7012      7012      6947      6947         6954      6931       6946      7010      6991

    PA_P                                    0.00206  -0.03453  -0.05886  -0.05804  -0.21505   0.20937   1.00000  -0.78573     -0.79990   0.75041   -0.70982   0.00288   0.07397
    P. Positive Affect                       0.8658    0.0047    <.0001    <.0001    <.0001    <.0001              <.0001       <.0001    <.0001     <.0001    0.8101    <.0001
                                               6697      6697      6697      6697      6947      6947      6966      6966         6963      6945       6962      6959      6940

    NA_P                                   -0.00764   0.04212   0.05569   0.05041   0.20298  -0.18694  -0.78573   1.00000      0.86713  -0.73295    0.81220   0.04907  -0.05485
    P. Negative Affect                       0.5322    0.0006    <.0001    <.0001    <.0001    <.0001    <.0001                 <.0001    <.0001     <.0001    <.0001    <.0001
                                               6697      6697      6697      6697      6947      6947      6966      6966         6963      6945       6962      6959      6940

    Depression_P                            0.00628   0.05685   0.09396   0.07359   0.24873  -0.22292  -0.79990   0.86713      1.00000  -0.77216    0.80360   0.01383  -0.06417
    P. Depression                            0.6070    <.0001    <.0001    <.0001    <.0001    <.0001    <.0001    <.0001                 <.0001     <.0001    0.2484    <.0001
                                               6704      6704      6704      6704      6954      6954      6963      6963         6976      6949       6965      6969      6950

    LifeSat_P                              -0.01200  -0.00803  -0.08876  -0.06014  -0.20543   0.26170   0.75041  -0.73295     -0.77216   1.00000   -0.65075   0.05109   0.07744
    P. Life Satisfaction                     0.3269    0.5119    <.0001    <.0001    <.0001    <.0001    <.0001    <.0001       <.0001               <.0001    <.0001    <.0001
                                               6682      6682      6682      6682      6931      6931      6945      6945         6949      6952       6946      6945      6926

    Anxiety_P                              -0.01665   0.07436   0.08137   0.06319   0.21772  -0.16703  -0.70982   0.81220      0.80360  -0.65075    1.00000   0.01209  -0.03795
    P. Anxiety                               0.1731    <.0001    <.0001    <.0001    <.0001    <.0001    <.0001    <.0001       <.0001    <.0001               0.3134    0.0016
                                               6696      6696      6696      6696      6946      6946      6962      6962         6965      6946       6967      6960      6941

    Gender_P                                0.01951   0.02044  -0.01630  -0.07348  -0.04792   0.20135   0.00288   0.04907      0.01383   0.05109    0.01209   1.00000   0.07982
    P. What gender do you identify with?     0.1088    0.0928    0.1801    <.0001    <.0001    <.0001    0.8101    <.0001       0.2484    <.0001     0.3134              <.0001
                                               6760      6760      6760      6760      7010      7010      6959      6959         6969      6945       6960      7393      7371

    Age_P                                   0.04357  -0.08548  -0.02092   0.03338  -0.04876   0.10407   0.07397  -0.05485     -0.06417   0.07744   -0.03795   0.07982   1.00000
    P. You are _______ years old today?      0.0003    <.0001    0.0859    0.0061    <.0001    <.0001    <.0001    <.0001       <.0001    <.0001     0.0016    <.0001
                                               6741      6741      6741      6741      6991      6991      6940      6940         6950      6926       6941      7371      7374


;

*Adversity panel graph*;

ods graphics/ noborder;
proc sgpanel data= lagtime noautolegend;
panelby id_p/
columns=4rows=4novarname;
series x= count y=adversitymonthly / lineattrs=(color=black pattern=1);
rowaxis label="Adversity"
labelattrs=(family="Garamond"size=12weight=bold) 
valueattrs=(family="Garamond"size=10);
colaxis label="wave"
labelattrs=(family="Garamond"size=12weight=bold) 
valueattrs=(family="Garamond"size=10);run;





































;

/*
LIFE SATISFACTION
*/


/*For calculating the ICC*/
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL lifesat_p =  

					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept   /SUBJECT=id_p TYPE=un GCORR;
RUN;
*                                                                             The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value      Pr > Z

                                                         UN(1,1)      ID_P         3.2494      0.2500     13.00      <.0001
                                                         Residual                  1.3344     0.02325     57.40      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         23085.8
                                                                       AIC (Smaller is Better)       23089.8
                                                                       AICC (Smaller is Better)      23089.8
                                                                       BIC (Smaller is Better)       23097.6


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             1       7394.67          <.0001


                                                                             Solution for Fixed Effects

                                                                                   Standard
                                                          Effect       Estimate       Error      DF    t Value    Pr > |t|

                                                          Intercept      7.5545     0.09636     361      78.40      <.0001



*ANY ADVERSITY;
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL lifesat_p =    adversitymonthly 
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=ar(1) GCORR;
RUN;
*
                                                                                       Number of Observations

                                                                    Number of Observations Read            7389
                                                                    Number of Observations Used            6942
                                                                    Number of Observations Not Used         447


                                                                                 Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     30261.41910608
                                                                    1              3     23251.55767674      0.00173908
                                                                    2              1     23241.17018676      0.00011478
                                                                    3              1     23240.53679961      0.00000083
                                                                    4              1     23240.53242753      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000     0.09345
                                                             2    adversitymonthly       1101         0.09345      1.0000

                                                                                         OS                                                   

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         Variance     ID_P         1.5497      0.1033     15.00      <.0001
                                                         AR(1)        ID_P        0.09345     0.07135      1.31      0.1903
                                                         Residual                  1.3134     0.02333     56.28      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         23240.5
                                                                       AIC (Smaller is Better)       23246.5
                                                                       AICC (Smaller is Better)      23246.5
                                                                       BIC (Smaller is Better)       23258.2


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             2       7020.89          <.0001


                                                                            Solution for Fixed Effects

                                                                                      Standard
                                                      Effect              Estimate       Error      DF    t Value    Pr > |t|

                                                      Intercept             7.8561     0.07587     361     103.55      <.0001
                                                      adversitymonthly     -0.3690     0.07870    6579      -4.69      <.0001

;


*Covariates only;
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL lifesat_p =    adversitymonthly womanc agec educ
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=ar(1) GCORR;
RUN;

* The Mixed Procedure
                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept           1113             1.0000      0.4894
                                                             2    adversitymonthly    1113             0.4894      1.0000

                                                                                         OS                                                       17:04 Thursday, March 10, 2022  30

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         Variance     ID_P         0.4135      2.1253      0.19      0.4229
                                                         AR(1)        ID_P         0.4894      8.3808      0.06      0.9534
                                                         Residual                  0.7456           0       .         .


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood            41.2
                                                                       AIC (Smaller is Better)          47.2
                                                                       AICC (Smaller is Better)         53.2
                                                                       BIC (Smaller is Better)          48.9


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             2          0.05          0.9737


                                                                            Solution for Fixed Effects

                                                                                      Standard
                                                      Effect              Estimate       Error      DF    t Value    Pr > |t|

                                                      Intercept             8.4619      0.5745       8      14.73      <.0001
                                                      adversitymonthly     -1.8392      0.7530       8      -2.44      0.0404
                                                      womanc                0.8098      0.7820       8       1.04      0.3307
                                                      agec                  0.1110     0.08777       8       1.26      0.2416
                                                      educ                  0.2126      0.1624       8       1.31      0.2268


;

*Just objective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL lifesat_p =    adversitymonthly  incomec unemployc greenc rentc womanc agec     


                      incomec*adversitymonthly unemployc*adversitymonthly greenc*adversitymonthly rentc*adversitymonthly
              

 					 

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*
                                                                                    
                                                                                 Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     28520.05185579
                                                                    1              4     21696.96208166       .
                                                                    2              1     21688.11108048      0.00024845
                                                                    3              1     21686.79986309      0.00000958
                                                                    4              1     21686.75320300      0.00000002
                                                                    5              1     21686.75312223      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.2232
                                                             2    adversitymonthly       1101          0.2232      1.0000

                                                                                         OS                                                       17:04 Thursday, March 10, 2022  38

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         2.7376      0.2363     11.59      <.0001
                                                         UN(2,1)      ID_P        0.09873     0.06534      1.51      0.1308
                                                         UN(2,2)      ID_P        0.07148     0.03368      2.12      0.0169
                                                         Residual                  1.2451     0.02258     55.14      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         21686.8
                                                                       AIC (Smaller is Better)       21694.8
                                                                       AICC (Smaller is Better)      21694.8
                                                                       BIC (Smaller is Better)       21710.1


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       6833.30          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 7.8378     0.09442     336      83.01      <.0001
                                                    adversitymonthly         -0.2749     0.03834    6303      -7.17      <.0001
                                                    incomec                  -0.9576      1.9089     336      -0.50      0.6163
                                                    unemployc                0.03853     0.04870     336       0.79      0.4295
                                                    greenc                    0.1177      0.1669     336       0.71      0.4811
                                                    rentc                   -0.01135    0.006737     336      -1.68      0.0931
                                                    womanc                    0.3634      0.1881     336       1.93      0.0542
                                                    agec                     0.03242     0.02138     336       1.52      0.1305
                                                    adversitymon*incomec      1.2093      0.7657    6303       1.58      0.1143
                                                    adversitym*unemployc    -0.04476     0.02094    6303      -2.14      0.0326
                                                    adversitymont*greenc     -0.1105     0.08571    6303      -1.29      0.1975
                                                    adversitymonth*rentc    0.001085    0.002808    6303       0.39      0.6991


;







*Just subjective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL lifesat_p =    adversitymonthly  disorderc cohesionc womanc agec


                      disorderc*adversitymonthly cohesionc*adversitymonthly 
              

 					 

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*      Covariance Parameter Estimates

                                                                                             Standard         Z
                                                          Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.2804
                                                             2    adversitymonthly       1101          0.2804      1.0000

                                                                                         OS                                                       16:11 Wednesday, March 9, 2022  52

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         2.5740      0.2217     11.61      <.0001
                                                         UN(2,1)      ID_P         0.1106     0.06362      1.74      0.0821
                                                         UN(2,2)      ID_P        0.06048     0.03366      1.80      0.0362
                                                         Residual                  1.3128     0.02337     56.17      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         22801.8
                                                                       AIC (Smaller is Better)       22809.8
                                                                       AICC (Smaller is Better)      22809.8
                                                                       BIC (Smaller is Better)       22825.3


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       6477.21          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 7.7973     0.09028     351      86.37      <.0001
                                                    adversitymonthly         -0.2839     0.03799    6541      -7.47      <.0001
                                                    disorderc                -0.3194      0.2097     351      -1.52      0.1287
                                                    cohesionc                 0.4765      0.1095     351       4.35      <.0001
                                                    womanc                    0.1487      0.1823     351       0.82      0.4154
                                                    agec                     0.02098     0.02047     351       1.02      0.3062
                                                    adversitym*disorderc    -0.08641     0.09080    6541      -0.95      0.3413
                                                    adversitym*cohesionc    -0.01061     0.04447    6541      -0.24      0.8115






;

*Both objective and subjective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL lifesat_p =    adversitymonthly incomec unemployc  greenc rentc   disorderc cohesionc womanc agec


                      incomec*adversitymonthly rentc*adversitymonthly   greenc*adversitymonthly  unemployc*adversitymonthly  disorderc*adversitymonthly cohesionc*adversitymonthly
              

 					  

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
* 
                                                            
                                                                                           Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     27984.62235391
                                                                    1              4     21675.44328388       .
                                                                    2              1     21666.84845493      0.00024788
                                                                    3              1     21665.54143006      0.00000964
                                                                    4              1     21665.49454674      0.00000002
                                                                    5              1     21665.49446479      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.2389
                                                             2    adversitymonthly       1101          0.2389      1.0000

                                                                                         OS                                                       17:04 Thursday, March 10, 2022  41

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         2.4755      0.2169     11.41      <.0001
                                                         UN(2,1)      ID_P         0.1016     0.06285      1.62      0.1060
                                                         UN(2,2)      ID_P        0.07304     0.03394      2.15      0.0157
                                                         Residual                  1.2454     0.02259     55.13      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         21665.5
                                                                       AIC (Smaller is Better)       21673.5
                                                                       AICC (Smaller is Better)      21673.5
                                                                       BIC (Smaller is Better)       21688.8


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       6319.13          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 7.8435     0.09035     334      86.81      <.0001
                                                    adversitymonthly         -0.2792     0.03849    6301      -7.25      <.0001
                                                    incomec                  -1.7472      1.8315     334      -0.95      0.3408
                                                    unemployc                0.06583     0.04793     334       1.37      0.1705
                                                    greenc                   0.08780      0.1606     334       0.55      0.5851
                                                    rentc                   -0.00472    0.006829     334      -0.69      0.4899
                                                    disorderc                -0.3659      0.2375     334      -1.54      0.1244
                                                    cohesionc                 0.4937      0.1113     334       4.44      <.0001
                                                    womanc                    0.2048      0.1830     334       1.12      0.2638
                                                    agec                     0.02602     0.02045     334       1.27      0.2043
                                                    adversitymon*incomec      1.2624      0.7706    6301       1.64      0.1014
                                                    adversitymonth*rentc    0.001731    0.002945    6301       0.59      0.5566
                                                    adversitymont*greenc     -0.1172     0.08578    6301      -1.37      0.1721
                                                    adversitym*unemployc    -0.04234     0.02160    6301      -1.96      0.0500
                                                    adversitym*disorderc    -0.06732      0.1040    6301      -0.65      0.5174
                                                    adversitym*cohesionc    -0.02231     0.04522    6301      -0.49      0.6217







;


/* random coefficient model life satisfaction all indicators  */
proc mixed data=lagtime method=ml;
   class id_p;
   model lifesat_p =    adversitymonthly incomec unemployc  greenc rentc   disorderc cohesionc womanc agec
                      incomec*adversitymonthly rentc*adversitymonthly   greenc*adversitymonthly  unemployc*adversitymonthly  disorderc*adversitymonthly cohesionc*adversitymonthly
               / s outpred=Pred;
   random int adversitymonthly/ sub=id_p;
run;

title "Predicted Individual Growth Curves - Life Satisfaction";
proc sgplot data=Pred noborder nowall;
  
   series x=adversitymonthly y=Pred / group=id_p 
   colorresponse=unemployc
   colormodel = (black red)
   lineattrs= (pattern=1);

 gradlegend/
title="Unemployment"
position=right titleattrs=
(family= "Garamond" size=12);

  xaxis label="Adversity"
labelattrs=(family="Garamond"size=12weight=bold) 
valueattrs=(family="Garamond"size=10);
yaxis label="Life Satisfaction"
labelattrs=(family="Garamond"size=12weight=bold) 
valueattrs=(family="Garamond"size=10);

   pbspline x=adversitymonthly y=Pred/
   lineattrs =(color = red thickness=5)
nomarkers;
run;















/*
DEPRESSIVE SYMPTOMS
*/


/*For calculating the ICC*/
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL depression_p =  

					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept   /SUBJECT=id_p TYPE=un GCORR;
RUN;
*        
                                                                                    Dimensions

                                                                        Covariance Parameters             2
                                                                        Columns in X                      1
                                                                        Columns in Z per Subject          1
                                                                        Subjects                        365
                                                                        Max Obs per Subject              25


                                                                              Number of Observations

                                                                    Number of Observations Read            7042
                                                                    Number of Observations Used            6978
                                                                    Number of Observations Not Used          64


                                                                                 Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     46670.31640365
                                                                    1              3     38762.18313103      0.00001544
                                                                    2              1     38761.97473175      0.00000006
                                                                    3              1     38761.97389409      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                         Participant
                                                                     Row    Effect       ID Number          Col1

                                                                       1    Intercept    1101             1.0000

                                                                                        JTF                                                       10:02 Friday, December 4, 2020 117

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value      Pr > Z

                                                         UN(1,1)      ID_P        33.4476      2.5635     13.05      <.0001
                                                         Residual                 12.4087      0.2157     57.52      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         38762.0
                                                                       AIC (Smaller is Better)       38766.0
                                                                       AICC (Smaller is Better)      38766.0
                                                                       BIC (Smaller is Better)       38773.8


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             1       7908.34          <.0001


                                                                            Solution for Fixed Effects

                                                                                    Standard
                                                        Effect          Estimate       Error      DF    t Value    Pr > |t|

                                                        Intercept         7.8271      0.3087     361      25.36      <.0001;


*ANY ADVERSITY;
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL depression_p =    adversitymonthly 
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*
                                                                                    Dimensions

                                                                        Covariance Parameters             4
                                                                        Columns in X                      2
                                                                        Columns in Z per Subject          2
                                                                        Subjects                        362
                                                                        Max Obs per Subject              25


                                                                              Number of Observations

                                                                    Number of Observations Read            7042
                                                                    Number of Observations Used            6962
                                                                    Number of Observations Not Used          80


                                                                                 Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     46259.85180016
                                                                    1              4     38594.87154108       .
                                                                    2              1     38577.00170190      0.00028566
                                                                    3              1     38572.70803228      0.00002776
                                                                    4              1     38572.32590163      0.00000034
                                                                    5              1     38572.32145100      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept           1101             1.0000      0.5310
                                                             2    adversitymonthly    1101             0.5310      1.0000

                                                                                        JTF                                                       10:02 Friday, December 4, 2020 119

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P        29.0758      2.4140     12.04      <.0001
                                                         UN(2,1)      ID_P         2.1559      0.6362      3.39      0.0007
                                                         UN(2,2)      ID_P         0.5670      0.3214      1.76      0.0389
                                                         Residual                 12.1784      0.2161     56.36      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         38572.3
                                                                       AIC (Smaller is Better)       38580.3
                                                                       AICC (Smaller is Better)      38580.3
                                                                       BIC (Smaller is Better)       38595.9


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7687.53          <.0001


                                                                            Solution for Fixed Effects

                                                                                      Standard
                                                      Effect              Estimate       Error      DF    t Value    Pr > |t|

                                                      Intercept             7.0203      0.2977     361      23.58      <.0001
                                                      adversitymonthly      1.1200      0.1144    6599       9.79      <.0001;




*Covariate only;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL depression_p =    adversitymonthly womanc agec
 
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
* The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P        28.7439      2.4079     11.94      <.0001
                                                         UN(2,1)      ID_P         2.2584      0.6378      3.54      0.0004
                                                         UN(2,2)      ID_P         0.5832      0.3239      1.80      0.0359
                                                         Residual                 12.1794      0.2165     56.25      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         38400.2
                                                                       AIC (Smaller is Better)       38408.2
                                                                       AICC (Smaller is Better)      38408.2
                                                                       BIC (Smaller is Better)       38423.8


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7595.19          <.0001


                                                                            Solution for Fixed Effects

                                                                                      Standard
                                                      Effect              Estimate       Error      DF    t Value    Pr > |t|

                                                      Intercept             6.9708      0.2978     354      23.40      <.0001
                                                      adversitymonthly      1.1269      0.1147    6574       9.82      <.0001
                                                      womanc              -0.07603      0.5992     354      -0.13      0.8991
                                                      agec                -0.09104     0.06820     354      -1.33      0.1828


;
*Just objective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL depression_p =    adversitymonthly  incomec  unemployc greenc rentc womanc agec


                      incomec*adversitymonthly  unemployc*adversitymonthly greenc*adversitymonthly rentc*adversitymonthly
              

 					  

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*Convergence criteria met.

 Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     44095.79405195
                                                                    1              4     36795.48100728       .
                                                                    2              1     36779.28775065      0.00027100
                                                                    3              1     36775.40843338      0.00002656
                                                                    4              1     36775.06035366      0.00000033
                                                                    5              1     36775.05625533      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.5096
                                                             2    adversitymonthly       1101          0.5096      1.0000

                                                                                         OS                                                       17:04 Thursday, March 10, 2022  44

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P        27.9090      2.3910     11.67      <.0001
                                                         UN(2,1)      ID_P         2.2668      0.6420      3.53      0.0004
                                                         UN(2,2)      ID_P         0.7090      0.3356      2.11      0.0173
                                                         Residual                 11.8544      0.2149     55.15      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         36775.1
                                                                       AIC (Smaller is Better)       36783.1
                                                                       AICC (Smaller is Better)      36783.1
                                                                       BIC (Smaller is Better)       36798.4


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7320.74          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 6.7607      0.3000     336      22.54      <.0001
                                                    adversitymonthly          1.1521      0.1175    6321       9.81      <.0001
                                                    incomec                  -0.3849      6.0648     336      -0.06      0.9494
                                                    unemployc                0.02408      0.1549     336       0.16      0.8765
                                                    greenc                   0.03210      0.5279     336       0.06      0.9516
                                                    rentc                    0.03683     0.02141     336       1.72      0.0862
                                                    womanc                   -0.1452      0.6050     336      -0.24      0.8105
                                                    agec                    -0.09514     0.06870     336      -1.38      0.1670
                                                    adversitymon*incomec     -2.6185      2.3457    6321      -1.12      0.2643
                                                    adversitym*unemployc     0.03969     0.06436    6321       0.62      0.5375
                                                    adversitymont*greenc      0.4533      0.2630    6321       1.72      0.0848
                                                    adversitymonth*rentc    -0.00377    0.008604    6321      -0.44      0.6613




;

*Just subjective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL depression_p =    adversitymonthly disorderc cohesionc womanc agec


                      disorderc*adversitymonthly cohesionc*adversitymonthly 
              

 					 

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*   Iteration History

                                                           
                                                                               Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.5983
                                                             2    adversitymonthly       1101          0.5983      1.0000

                                                                                         OS                                                       16:11 Wednesday, March 9, 2022  63

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P        25.6098      2.1838     11.73      <.0001
                                                         UN(2,1)      ID_P         2.3477      0.6097      3.85      0.0001
                                                         UN(2,2)      ID_P         0.6013      0.3269      1.84      0.0329
                                                         Residual                 12.1944      0.2170     56.19      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         38298.5
                                                                       AIC (Smaller is Better)       38306.5
                                                                       AICC (Smaller is Better)      38306.5
                                                                       BIC (Smaller is Better)       38322.0


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       6992.53          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 6.9221      0.2832     351      24.45      <.0001
                                                    adversitymonthly          1.1374      0.1150    6560       9.89      <.0001
                                                    disorderc                 2.1337      0.6574     351       3.25      0.0013
                                                    cohesionc                -1.1738      0.3439     351      -3.41      0.0007
                                                    womanc                    0.4610      0.5799     351       0.79      0.4272
                                                    agec                    -0.06737     0.06497     351      -1.04      0.3005
                                                    adversitym*disorderc     0.05138      0.2749    6560       0.19      0.8518
                                                    adversitym*cohesionc     0.08716      0.1347    6560       0.65      0.5176



                                                                    


;

*Both objective and subjective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL depression_p =    adversitymonthly  incomec unemploy greenc rentc   disorderc cohesionc womanc agec


                      incomec*adversitymonthly  unemployc*adversitymonthly rentc*adversitymonthly greenc*adversitymonthly  disorderc*adversitymonthly cohesionc*adversitymonthly
              

 					  

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow;
 RANDOM intercept adversitymonthly  /SUBJECT=id_p TYPE=un GCORR;
RUN;
*
                                                                            variance Parameters             4
                                                                        Columns in X                     16
                                                                        Columns in Z per Subject          2
                                                                        Subjects                        343
                                                                        Max Obs per Subject              24


                                                                              Number of Observations

                                                                    Number of Observations Read            7389
                                                                    Number of Observations Used            6669
                                                                    Number of Observations Not Used         720


                                                                                 Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     43556.17599593
                                                                    1              4     36763.14034892       .
                                                                    2              1     36748.19022228      0.00024494
                                                                    3              1     36744.70152207      0.00002232
                                                                    4              1     36744.41050130      0.00000024
                                                                    5              1     36744.40755859      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.5512
                                                             2    adversitymonthly       1101          0.5512      1.0000

                                                                                         OS                                                       17:04 Thursday, March 10, 2022  47

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P        25.1706      2.1884     11.50      <.0001
                                                         UN(2,1)      ID_P         2.3367      0.6163      3.79      0.0001
                                                         UN(2,2)      ID_P         0.7140      0.3361      2.12      0.0168
                                                         Residual                 11.8589      0.2151     55.14      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         36744.4
                                                                       AIC (Smaller is Better)       36752.4
                                                                       AICC (Smaller is Better)      36752.4
                                                                       BIC (Smaller is Better)       36767.8


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       6811.77          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 7.3538      0.8909     334       8.25      <.0001
                                                    adversitymonthly          1.1660      0.1176    6319       9.92      <.0001
                                                    incomec                   1.7031      5.8071     334       0.29      0.7695
                                                    Unemploy                 -0.1082      0.1521     334      -0.71      0.4775
                                                    greenc                   0.09873      0.5072     334       0.19      0.8458
                                                    rentc                   0.007494     0.02166     334       0.35      0.7295
                                                    disorderc                 2.1735      0.7526     334       2.89      0.0041
                                                    cohesionc                -1.2211      0.3535     334      -3.45      0.0006
                                                    womanc                    0.2813      0.5883     334       0.48      0.6328
                                                    agec                    -0.07736     0.06563     334      -1.18      0.2394
                                                    adversitymon*incomec     -2.7903      2.3536    6319      -1.19      0.2358
                                                    adversitym*unemployc     0.03476     0.06623    6319       0.52      0.5997
                                                    adversitymonth*rentc    -0.00572    0.008997    6319      -0.64      0.5250
                                                    adversitymont*greenc      0.4852      0.2627    6319       1.85      0.0647
                                                    adversitym*disorderc      0.1976      0.3177    6319       0.62      0.5339
                                                    adversitym*cohesionc      0.1228      0.1383    6319       0.89      0.3746




;



/*
ANXIETY
*/


/*For calculating the ICC*/
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL anxiety_p =  

					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept   /SUBJECT=id_p TYPE=un GCORR;
RUN;
*        
                                                                                    Dimensions

                                                                        Covariance Parameters             2
                                                                        Columns in X                      1
                                                                        Columns in Z per Subject          1
                                                                        Subjects                        365
                                                                        Max Obs per Subject              25


                                                                              Number of Observations

                                                                    Number of Observations Read            7042
                                                                    Number of Observations Used            6969
                                                                    Number of Observations Not Used          73


                                                                                 Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1      8030.20076487
                                                                    1              3      -784.58508075      0.00001689
                                                                    2              1      -784.70348484      0.00000004
                                                                    3              1      -784.70376385      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                         Participant
                                                                     Row    Effect       ID Number          Col1

                                                                       1    Intercept    1101             1.0000

                                                                                        JTF                                                       10:02 Friday, December 4, 2020 134

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value      Pr > Z

                                                         UN(1,1)      ID_P         0.1383     0.01054     13.12      <.0001
                                                         Residual                 0.04244    0.000738     57.48      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood          -784.7
                                                                       AIC (Smaller is Better)        -780.7
                                                                       AICC (Smaller is Better)       -780.7
                                                                       BIC (Smaller is Better)        -772.9


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             1       8814.90          <.0001


                                                                             Solution for Fixed Effects

                                                                                   Standard
                                                          Effect       Estimate       Error      DF    t Value    Pr > |t|

                                                          Intercept      1.5831     0.01980     361      79.97      <.0001;


*ANY ADVERSITY;
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL anxiety_p =    adversitymonthly 
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*
                                                                                    Dimensions

                                                                        Covariance Parameters             4
                                                                        Columns in X                      2
                                                                        Columns in Z per Subject          2
                                                                        Subjects                        362
                                                                        Max Obs per Subject              25


                                                                              Number of Observations

                                                                    Number of Observations Read            7042
                                                                    Number of Observations Used            6960
                                                                    Number of Observations Not Used          82

                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept           1101             1.0000      0.2422
                                                             2    adversitymonthly    1101             0.2422      1.0000


                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.1277     0.01050     12.15      <.0001
                                                         UN(2,1)      ID_P       0.004058    0.002576      1.58      0.1151
                                                         UN(2,2)      ID_P       0.002199    0.001204      1.83      0.0338
                                                         Residual                 0.04181    0.000743     56.24      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood          -838.2
                                                                       AIC (Smaller is Better)        -830.2
                                                                       AICC (Smaller is Better)       -830.2
                                                                       BIC (Smaller is Better)        -814.6


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       8621.52          <.0001


                                                                            Solution for Fixed Effects

                                                                                      Standard
                                                      Effect              Estimate       Error      DF    t Value    Pr > |t|

                                                      Intercept             1.5487     0.01956     361      79.16      <.0001
													adversitymonthly     0.04754    0.006851    6597       6.94      <.0001;

*Covariates only;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL anxiety_p =    adversitymonthly womanc agec
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*  The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.1262     0.01046     12.07      <.0001
                                                         UN(2,1)      ID_P       0.004131    0.002607      1.58      0.1130
                                                         UN(2,2)      ID_P       0.002227    0.001206      1.85      0.0324
                                                         Residual                 0.04177    0.000744     56.14      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood          -837.7
                                                                       AIC (Smaller is Better)        -829.7
                                                                       AICC (Smaller is Better)       -829.7
                                                                       BIC (Smaller is Better)        -814.2


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       8579.97          <.0001


                                                                            Solution for Fixed Effects

                                                                                      Standard
                                                      Effect              Estimate       Error      DF    t Value    Pr > |t|

                                                      Intercept             1.5454     0.01958     354      78.95      <.0001
                                                      adversitymonthly     0.04763    0.006866    6572       6.94      <.0001
                                                      womanc              0.007189     0.03912     354       0.18      0.8543
                                                      agec                -0.00408    0.004455     354      -0.91      0.3609



;

  *Just objective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL anxiety_p =    adversitymonthly  incomec  unemployc greenc rentc womanc agec


                      incomec*adversitymonthly  unemployc*adversitymonthly greenc*adversitymonthly rentc*adversitymonthly
              

 					  

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;                                  
*   Number of Observations

                                                                  
                                                                            Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1      7392.93716234
                                                                    1              4      -888.16761609       .
                                                                    2              1      -916.84540643      0.00114756
                                                                    3              1      -925.94551567      0.00019539
                                                                    4              1      -927.37890857      0.00000792
                                                                    5              1      -927.43247746      0.00000002
                                                                    6              1      -927.43258012      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.2310
                                                             2    adversitymonthly       1101          0.2310      1.0000

                                                                                         OS                                                       17:04 Thursday, March 10, 2022  50

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.1264     0.01071     11.81      <.0001
                                                         UN(2,1)      ID_P       0.003970    0.002652      1.50      0.1344
                                                         UN(2,2)      ID_P       0.002336    0.001196      1.95      0.0254
                                                         Residual                 0.04064    0.000738     55.07      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood          -927.4
                                                                       AIC (Smaller is Better)        -919.4
                                                                       AICC (Smaller is Better)       -919.4
                                                                       BIC (Smaller is Better)        -904.1


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       8320.37          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 1.5371     0.01999     336      76.88      <.0001
                                                    adversitymonthly         0.04724    0.006939    6318       6.81      <.0001
                                                    incomec                  -0.3881      0.4044     336      -0.96      0.3379
                                                    unemployc               -0.00195     0.01033     336      -0.19      0.8507
                                                    greenc                   0.02356     0.03470     336       0.68      0.4977
                                                    rentc                   0.002035    0.001427     336       1.43      0.1547
                                                    womanc                  0.007021     0.04007     336       0.18      0.8610
                                                    agec                    -0.00425    0.004554     336      -0.93      0.3515
                                                    adversitymon*incomec    -0.00415      0.1386    6318      -0.03      0.9761
                                                    adversitym*unemployc    0.008272    0.003792    6318       2.18      0.0292
                                                    adversitymont*greenc     0.02434     0.01550    6318       1.57      0.1165
                                                    adversitymonth*rentc    -0.00021    0.000508    6318      -0.42      0.6749





;
*Just subjective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL anxiety_p =    adversitymonthly  disorderc cohesionc womanc agec


                      disorderc*adversitymonthly cohesionc*adversitymonthly 
              

 					  

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*
                                                                            Convergence criteria met.



                                                                                   Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.2731
                                                             2    adversitymonthly       1101          0.2731      1.0000

                                                                                         OS                                                       16:11 Wednesday, March 9, 2022  74

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.1184    0.009898     11.96      <.0001
                                                         UN(2,1)      ID_P       0.004113    0.002515      1.64      0.1019
                                                         UN(2,2)      ID_P       0.001916    0.001185      1.62      0.0530
                                                         Residual                 0.04183    0.000746     56.05      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood          -834.8
                                                                       AIC (Smaller is Better)        -826.8
                                                                       AICC (Smaller is Better)       -826.8
                                                                       BIC (Smaller is Better)        -811.3


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       8151.67          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 1.5430     0.01904     351      81.05      <.0001
                                                    adversitymonthly         0.04845    0.006795    6557       7.13      <.0001
                                                    disorderc                 0.1171     0.04414     351       2.65      0.0084
                                                    cohesionc               -0.05322     0.02313     351      -2.30      0.0220
                                                    womanc                   0.03121     0.03866     351       0.81      0.4199
                                                    agec                    -0.00285    0.004340     351      -0.66      0.5118
                                                    adversitym*disorderc     0.03173     0.01624    6557       1.95      0.0508
                                                    adversitym*cohesionc     0.01488    0.007952    6557       1.87      0.0613




                                                                    


;

*Both objective and subjective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL anxiety_p =    adversitymonthly  incomec unemployc  greenc rentc   disorderc cohesionc womanc agec


                      incomec*adversitymonthly unemployc*adversitymonthly rentc*adversitymonthly greenc*adversitymonthly  disorderc*adversitymonthly cohesionc*adversitymonthly
              

 					

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;

*      
                                                                            
                                                                                 Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1      7046.45896968
                                                                    1              4      -882.62734745       .
                                                                    2              1      -914.96803099      0.00139196
                                                                    3              1      -926.09517898      0.00027060
                                                                    4              1      -928.10520915      0.00001453
                                                                    5              1      -928.20435991      0.00000005
                                                                    6              1      -928.20470003      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.2834
                                                             2    adversitymonthly       1101          0.2834      1.0000

                                                                                         OS                                                       17:04 Thursday, March 10, 2022  53

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.1185     0.01011     11.72      <.0001
                                                         UN(2,1)      ID_P       0.004446    0.002547      1.75      0.0809
                                                         UN(2,2)      ID_P       0.002077    0.001179      1.76      0.0390
                                                         Residual                 0.04067    0.000739     55.05      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood          -928.2
                                                                       AIC (Smaller is Better)        -920.2
                                                                       AICC (Smaller is Better)       -920.2
                                                                       BIC (Smaller is Better)        -904.9


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7974.66          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 1.5370     0.01941     334      79.18      <.0001
                                                    adversitymonthly         0.04822    0.006874    6316       7.02      <.0001
                                                    incomec                  -0.2860      0.3937     334      -0.73      0.4681
                                                    unemployc               -0.01029     0.01032     334      -1.00      0.3197
                                                    greenc                   0.02624     0.03380     334       0.78      0.4381
                                                    rentc                   0.000239    0.001468     334       0.16      0.8707
                                                    disorderc                 0.1423     0.05095     334       2.79      0.0055
                                                    cohesionc               -0.05280     0.02397     334      -2.20      0.0283
                                                    womanc                   0.02275     0.03961     334       0.57      0.5661
                                                    agec                    -0.00335    0.004428     334      -0.76      0.4493
                                                    adversitymon*incomec    -0.03002      0.1376    6316      -0.22      0.8273
                                                    adversitym*unemployc    0.007422    0.003867    6316       1.92      0.0550
                                                    adversitymonth*rentc    -0.00039    0.000526    6316      -0.75      0.4554
                                                    adversitymont*greenc     0.02583     0.01540    6316       1.68      0.0934
                                                    adversitym*disorderc     0.02581     0.01859    6316       1.39      0.1651
                                                    adversitym*cohesionc     0.01616    0.008071    6316       2.00      0.0453



;






/*
POSITIVE AFFECT
*/


/*For calculating the ICC*/
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL pa_p =  

					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept   /SUBJECT=id_p TYPE=un GCORR;
RUN;
*        
                                                                                    Dimensions

                                                                        Covariance Parameters             2
                                                                        Columns in X                      1
                                                                        Columns in Z per Subject          1
                                                                        Subjects                        365
                                                                        Max Obs per Subject              25


                                                                              Number of Observations

                                                                    Number of Observations Read            7042
                                                                    Number of Observations Used            6968
                                                                    Number of Observations Not Used          74


                                                                                 Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     22170.36379893
                                                                    1              3     13802.40625867      0.00035284
                                                                    2              1     13802.22342041      0.00000130
                                                                    3              1     13802.22277074      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                         Participant
                                                                     Row    Effect       ID Number          Col1

                                                                       1    Intercept    1101             1.0000

                                                                                        JTF                                                       10:02 Friday, December 4, 2020 152

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value      Pr > Z

                                                         UN(1,1)      ID_P         1.0273     0.07850     13.09      <.0001
                                                         Residual                  0.3460    0.006020     57.48      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         13802.2
                                                                       AIC (Smaller is Better)       13806.2
                                                                       AICC (Smaller is Better)      13806.2
                                                                       BIC (Smaller is Better)       13814.0


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             1       8368.14          <.0001


                                                                             Solution for Fixed Effects

                                                                                   Standard
                                                          Effect       Estimate       Error      DF    t Value    Pr > |t|

                                                          Intercept      3.9954     0.05403     361      73.96      <.0001;


*ANY ADVERSITY;
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL pa_p =    adversitymonthly 
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*
                                                                                    Dimensions

                                                                        Covariance Parameters             4
                                                                        Columns in X                      2
                                                                        Columns in Z per Subject          2
                                                                        Subjects                        362
                                                                        Max Obs per Subject              25


                                                                              Number of Observations

                                                                    Number of Observations Read            7042
                                                                    Number of Observations Used            6963
                                                                    Number of Observations Not Used          79

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.9753     0.07981     12.22      <.0001
                                                         UN(2,1)      ID_P       0.008219     0.02145      0.38      0.7015
                                                         UN(2,2)      ID_P        0.03328     0.01080      3.08      0.0010
                                                         Residual                  0.3374    0.005999     56.23      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         13708.7
                                                                       AIC (Smaller is Better)       13716.7
                                                                       AICC (Smaller is Better)      13716.7
                                                                       BIC (Smaller is Better)       13732.3


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       8189.42          <.0001


                                                                            Solution for Fixed Effects

                                                                                      Standard
                                                      Effect              Estimate       Error      DF    t Value    Pr > |t|

                                                      Intercept             4.1097     0.05438     361      75.58      <.0001
                                                      adversitymonthly     -0.1602     0.02104    6600      -7.62      <.0001;






*Covariates only;
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL pa_p =    adversitymonthly  womanc agec
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
* Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000     0.05379
                                                             2    adversitymonthly       1101         0.05379      1.0000

                                                                                         OS                                                       16:11 Wednesday, March 9, 2022  80

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.9649     0.07957     12.13      <.0001
                                                         UN(2,1)      ID_P       0.009638     0.02139      0.45      0.6523
                                                         UN(2,2)      ID_P        0.03328     0.01081      3.08      0.0010
                                                         Residual                  0.3377    0.006016     56.13      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         13655.7
                                                                       AIC (Smaller is Better)       13663.7
                                                                       AICC (Smaller is Better)      13663.7
                                                                       BIC (Smaller is Better)       13679.2


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       8093.46          <.0001


                                                                            Solution for Fixed Effects

                                                                                      Standard
                                                      Effect              Estimate       Error      DF    t Value    Pr > |t|

                                                      Intercept             4.1180     0.05442     354      75.67      <.0001
                                                      adversitymonthly     -0.1615     0.02107    6575      -7.67      <.0001
                                                      womanc               0.04812      0.1075     354       0.45      0.6548
                                                      agec                 0.01622     0.01225     354       1.32      0.1865



;
 *Just objective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL pa_p =    adversitymonthly  incomec  unemployc greenc rentc womanc agec


                      incomec*adversitymonthly  unemployc*adversitymonthly greenc*adversitymonthly rentc*adversitymonthly
              

 					  

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;                                  
*
                                                                                Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000     0.03104
                                                             2    adversitymonthly       1101         0.03104      1.0000

                                                                                         OS                                                       16:11 Wednesday, March 9, 2022  82

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.9615     0.08109     11.86      <.0001
                                                         UN(2,1)      ID_P       0.005862     0.02195      0.27      0.7894
                                                         UN(2,2)      ID_P        0.03709     0.01116      3.32      0.0004
                                                         Residual                  0.3290    0.005977     55.04      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         13009.5
                                                                       AIC (Smaller is Better)       13017.5
                                                                       AICC (Smaller is Better)      13017.5
                                                                       BIC (Smaller is Better)       13032.9


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7835.25          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 4.1492     0.05547     336      74.80      <.0001
                                                    adversitymonthly         -0.1617     0.02160    6321      -7.49      <.0001
                                                    incomec                   0.1376      1.1219     336       0.12      0.9024
                                                    unemployc               0.001705     0.02862     336       0.06      0.9525
                                                    greenc                  0.009045     0.09667     336       0.09      0.9255
                                                    rentc                   -0.00276    0.003959     336      -0.70      0.4868
                                                    womanc                   0.06133      0.1098     336       0.56      0.5768
                                                    agec                     0.02017     0.01248     336       1.62      0.1071
                                                    adversitymon*incomec     0.07084      0.4325    6321       0.16      0.8699
                                                    adversitym*unemployc    -0.00512     0.01167    6321      -0.44      0.6610
                                                    adversitymont*greenc    -0.04507     0.04665    6321      -0.97      0.3341
                                                    adversitymonth*rentc    -0.00154    0.001577    6321      -0.98      0.3290




;
*Just subjective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL pa_p =         adversitymonthly  disorderc cohesionc womanc agec


                      disorderc*adversitymonthly cohesionc*adversitymonthly 
              

 					  

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*   The Mixed Procedure

                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000     0.07838
                                                             2    adversitymonthly       1101         0.07838      1.0000

                                                                                         OS                                                       16:11 Wednesday, March 9, 2022  85

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.8953     0.07452     12.02      <.0001
                                                         UN(2,1)      ID_P        0.01335     0.02056      0.65      0.5161
                                                         UN(2,2)      ID_P        0.03241     0.01077      3.01      0.0013
                                                         Residual                  0.3379    0.006026     56.07      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         13616.9
                                                                       AIC (Smaller is Better)       13624.9
                                                                       AICC (Smaller is Better)      13624.9
                                                                       BIC (Smaller is Better)       13640.4


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7624.52          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 4.1278     0.05269     351      78.35      <.0001
                                                    adversitymonthly         -0.1654     0.02103    6560      -7.87      <.0001
                                                    disorderc                -0.2513      0.1222     351      -2.06      0.0405
                                                    cohesionc                 0.2126     0.06394     351       3.32      0.0010
                                                    womanc                  -0.03386      0.1059     351      -0.32      0.7493
                                                    agec                     0.01221     0.01189     351       1.03      0.3054
                                                    adversitym*disorderc    -0.07343     0.05001    6560      -1.47      0.1420
                                                    adversitym*cohesionc    -0.04571     0.02466    6560      -1.85      0.0638




                                                                    


;

*Both objective and subjective indicators*;


PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL pa_p =         adversitymonthly  greenc unemployc  incomec rentc disorderc cohesionc womanc agec


                      greenc*adversitymonthly  unemployc*adversitymonthly rentc*adversitymonthly incomec*adversitymonthly disorderc*adversitymonthly  cohesionc*adversitymonthly 
              

 					  

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*


    Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     20389.46289817
                                                                    1              3     12995.18132004      0.00157664
                                                                    2              2     12994.63603879      0.00003169
                                                                    3              1     12994.62371454      0.00000001
                                                                    4              1     12994.62370919      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000     0.06188
                                                             2    adversitymonthly       1101         0.06188      1.0000

                                                                                         OS                                                       17:04 Thursday, March 10, 2022  56

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.8839     0.07518     11.76      <.0001
                                                         UN(2,1)      ID_P        0.01110     0.02095      0.53      0.5963
                                                         UN(2,2)      ID_P        0.03639     0.01113      3.27      0.0005
                                                         Residual                  0.3290    0.005978     55.04      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         12994.6
                                                                       AIC (Smaller is Better)       13002.6
                                                                       AICC (Smaller is Better)      13002.6
                                                                       BIC (Smaller is Better)       13018.0


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7394.84          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 4.1516     0.05342     334      77.72      <.0001
                                                    adversitymonthly         -0.1651     0.02156    6319      -7.66      <.0001
                                                    greenc                  -0.00326     0.09348     334      -0.03      0.9722
                                                    unemployc                0.02294     0.02835     334       0.81      0.4191
                                                    incomec                  -0.2556      1.0833     334      -0.24      0.8136
                                                    rentc                   0.002055    0.004040     334       0.51      0.6112
                                                    disorderc                -0.3342      0.1403     334      -2.38      0.0178
                                                    cohesionc                 0.2287     0.06587     334       3.47      0.0006
                                                    womanc                  -0.00775      0.1077     334      -0.07      0.9426
                                                    agec                     0.01686     0.01204     334       1.40      0.1623
                                                    adversitymont*greenc    -0.04924     0.04653    6319      -1.06      0.2899
                                                    adversitym*unemployc    -0.00376     0.01199    6319      -0.31      0.7539
                                                    adversitymonth*rentc    -0.00124    0.001648    6319      -0.75      0.4519
                                                    adversitymon*incomec      0.1507      0.4329    6319       0.35      0.7277
                                                    adversitym*disorderc    -0.05331     0.05805    6319      -0.92      0.3584
                                                    adversitym*cohesionc    -0.04667     0.02540    6319      -1.84      0.0662


;





/*
NEGATIVE AFFECT
*/


/*For calculating the ICC*/
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL na_p =  

					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept   /SUBJECT=id_p TYPE=un GCORR;
RUN;
*       
                                                                                    Dimensions

                                                                        Covariance Parameters             2
                                                                        Columns in X                      1
                                                                        Columns in Z per Subject          1
                                                                        Subjects                        365
                                                                        Max Obs per Subject              25


                                                                              Number of Observations

                                                                    Number of Observations Read            7042
                                                                    Number of Observations Used            6968
                                                                    Number of Observations Not Used          74


                                                                                 Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     20672.26308317
                                                                    1              3     12533.71648632      0.00111293
                                                                    2              1     12533.56041039      0.00000352
                                                                    3              1     12533.55993300      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                         Participant
                                                                     Row    Effect       ID Number          Col1

                                                                       1    Intercept    1101             1.0000

                                                                                        JTF                                                       10:02 Friday, December 4, 2020 169

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value      Pr > Z

                                                         UN(1,1)      ID_P         0.8158     0.06231     13.09      <.0001
                                                         Residual                  0.2892    0.005030     57.48      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         12533.6
                                                                       AIC (Smaller is Better)       12537.6
                                                                       AICC (Smaller is Better)      12537.6
                                                                       BIC (Smaller is Better)       12545.4


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             1       8138.70          <.0001


                                                                             Solution for Fixed Effects

                                                                                   Standard
                                                          Effect       Estimate       Error      DF    t Value    Pr > |t|

                                                          Intercept      2.2307     0.04818     361      46.30      <.0001;


*ANY ADVERSITY;
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL na_p =    adversitymonthly 
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*
                                                                                    Dimensions

                                                                        Covariance Parameters             4
                                                                        Columns in X                      2
                                                                        Columns in Z per Subject          2
                                                                        Subjects                        362
                                                                        Max Obs per Subject              25


                                                                              Number of Observations

                                                                    Number of Observations Read            7042
                                                                    Number of Observations Used            6963
                                                                    Number of Observations Not Used          79


                                                                                 Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     20349.38769827
                                                                    1              4     12464.46499989       .
                                                                    2              1     12445.78577846      0.02241101
                                                                    3              1     12441.23660425      0.00221095
                                                                    4              1     12440.82006963      0.00002895
                                                                    5              1     12440.81491888      0.00000001


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept           1101             1.0000      0.3055
                                                             2    adversitymonthly    1101             0.3055      1.0000

                                                                                        JTF                                                       10:02 Friday, December 4, 2020 171

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.7421     0.06135     12.10      <.0001
                                                         UN(2,1)      ID_P        0.03074     0.01606      1.91      0.0556
                                                         UN(2,2)      ID_P        0.01364    0.007428      1.84      0.0332
                                                         Residual                  0.2840    0.005038     56.37      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         12440.8
                                                                       AIC (Smaller is Better)       12448.8
                                                                       AICC (Smaller is Better)      12448.8
                                                                       BIC (Smaller is Better)       12464.4


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7908.57          <.0001


                                                                            Solution for Fixed Effects

                                                                                      Standard
                                                      Effect              Estimate       Error      DF    t Value    Pr > |t|

                                                      Intercept             2.1196     0.04744     361      44.68      <.0001
                                                      adversitymonthly      0.1557     0.01766    6600       8.82      <.0001;



*Covariates only;
PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL na_p =    adversitymonthly womanc agec
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*  Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.2989
                                                             2    adversitymonthly       1101          0.2989      1.0000

                                                                                         OS                                                       16:11 Wednesday, March 9, 2022  91

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.7408     0.06181     11.99      <.0001
                                                         UN(2,1)      ID_P        0.03018     0.01630      1.85      0.0642
                                                         UN(2,2)      ID_P        0.01376    0.007466      1.84      0.0327
                                                         Residual                  0.2842    0.005052     56.25      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         12395.0
                                                                       AIC (Smaller is Better)       12403.0
                                                                       AICC (Smaller is Better)      12403.1
                                                                       BIC (Smaller is Better)       12418.6


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7808.30          <.0001


                                                                            Solution for Fixed Effects

                                                                                      Standard
                                                      Effect              Estimate       Error      DF    t Value    Pr > |t|

                                                      Intercept             2.1137     0.04768     354      44.33      <.0001
                                                      adversitymonthly      0.1557     0.01771    6575       8.79      <.0001
                                                      womanc               0.05688     0.09527     354       0.60      0.5508
                                                      agec                -0.01014     0.01085     354      -0.93      0.3506



;

 *Just objective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL na_p =    adversitymonthly  incomec  unemployc greenc rentc womanc agec


                      incomec*adversitymonthly  unemployc*adversitymonthly greenc*adversitymonthly  rentc*adversitymonthly
              

 					   

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;                                  
*
                                                          
                                                                             Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     19347.09128179
                                                                    1              4     11716.53458531       .
                                                                    2              1     11701.08478207      0.01148267
                                                                    3              1     11697.53192957      0.00100603
                                                                    4              1     11697.24505125      0.00001005
                                                                    5              1     11697.24233076      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.2118
                                                             2    adversitymonthly       1101          0.2118      1.0000

                                                                                         OS                                                       17:04 Thursday, March 10, 2022  59

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.7487     0.06381     11.73      <.0001
                                                         UN(2,1)      ID_P        0.02261     0.01679      1.35      0.1782
                                                         UN(2,2)      ID_P        0.01522    0.007466      2.04      0.0208
                                                         Residual                  0.2725    0.004941     55.15      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         11697.2
                                                                       AIC (Smaller is Better)       11705.2
                                                                       AICC (Smaller is Better)      11705.2
                                                                       BIC (Smaller is Better)       11720.6


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7649.85          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 2.0884     0.04888     336      42.72      <.0001
                                                    adversitymonthly          0.1540     0.01791    6321       8.60      <.0001
                                                    incomec                  -0.2394      0.9886     336      -0.24      0.8088
                                                    unemployc               0.004770     0.02525     336       0.19      0.8503
                                                    greenc                   0.01594     0.08535     336       0.19      0.8520
                                                    rentc                   0.002140    0.003488     336       0.61      0.5400
                                                    womanc                   0.04245     0.09770     336       0.43      0.6642
                                                    agec                    -0.01269     0.01110     336      -1.14      0.2538
                                                    adversitymon*incomec     -0.4056      0.3577    6321      -1.13      0.2569
                                                    adversitym*unemployc    0.001575    0.009790    6321       0.16      0.8722
                                                    adversitymont*greenc     0.04198     0.04008    6321       1.05      0.2949
                                                    adversitymonth*rentc    0.001081    0.001312    6321       0.82      0.4103



;
*Just subjective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL na_p =    adversitymonthly  disorderc cohesionc womanc agec


                      disorderc*adversitymonthly cohesionc*adversitymonthly 
              

 					 

					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;
*
                                                                           
                                                                                Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.3461
                                                             2    adversitymonthly       1101          0.3461      1.0000

                                                                                         OS                                                       16:11 Wednesday, March 9, 2022  96

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.6938     0.05857     11.85      <.0001
                                                         UN(2,1)      ID_P        0.03206     0.01589      2.02      0.0436
                                                         UN(2,2)      ID_P        0.01237    0.007332      1.69      0.0458
                                                         Residual                  0.2841    0.005056     56.19      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         12354.7
                                                                       AIC (Smaller is Better)       12362.7
                                                                       AICC (Smaller is Better)      12362.8
                                                                       BIC (Smaller is Better)       12378.2


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7380.35          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 2.1054     0.04634     351      45.43      <.0001
                                                    adversitymonthly          0.1588     0.01758    6560       9.04      <.0001
                                                    disorderc                 0.1841      0.1075     351       1.71      0.0877
                                                    cohesionc                -0.1768     0.05628     351      -3.14      0.0018
                                                    womanc                    0.1252     0.09421     351       1.33      0.1847
                                                    agec                    -0.00680     0.01057     351      -0.64      0.5208
                                                    adversitym*disorderc     0.09228     0.04203    6560       2.20      0.0281
                                                    adversitym*cohesionc     0.03973     0.02057    6560       1.93      0.0535




                                                                    


;

*Both objective and subjective indicators*;

PROC MIXED DATA=lagtime NOCLPRINT COVTEST METHOD=REML;
 CLASS id_p;
 MODEL na_p =    adversitymonthly  incomec unemployc  greenc rentc  disorderc cohesionc womanc agec


                      incomec*adversitymonthly unemployc*adversitymonthly rentc*adversitymonthly  greenc*adversitymonthly  disorderc*adversitymonthly cohesionc*adversitymonthly
              

 					  
					  
      
					/SOLUTION DDFM=BW OUTP=verbnogrow ;
 RANDOM intercept  adversitymonthly /SUBJECT=id_p TYPE=un GCORR;
RUN;

*  Convergence criteria met.


                                                                             Iteration History

                                                            Iteration    Evaluations    -2 Res Log Like       Criterion

                                                                    0              1     18937.82916580
                                                                    1              4     11702.17005862       .
                                                                    2              1     11688.18402636      0.00926696
                                                                    3              1     11685.31461802      0.00068333
                                                                    4              1     11685.11975987      0.00000477
                                                                    5              1     11685.11846161      0.00000000


                                                                             Convergence criteria met.


                                                                           Estimated G Correlation Matrix

                                                                                      Participant
                                                           Row    Effect              ID Number          Col1        Col2

                                                             1    Intercept              1101          1.0000      0.2721
                                                             2    adversitymonthly       1101          0.2721      1.0000

                                                                                         OS                                                       17:04 Thursday, March 10, 2022  62

                                                                                The Mixed Procedure

                                                                           Covariance Parameter Estimates

                                                                                             Standard         Z
                                                         Cov Parm     Subject    Estimate       Error     Value        Pr Z

                                                         UN(1,1)      ID_P         0.6976     0.06007     11.61      <.0001
                                                         UN(2,1)      ID_P        0.02636     0.01624      1.62      0.1045
                                                         UN(2,2)      ID_P        0.01345    0.007304      1.84      0.0327
                                                         Residual                  0.2726    0.004943     55.14      <.0001


                                                                                  Fit Statistics

                                                                       -2 Res Log Likelihood         11685.1
                                                                       AIC (Smaller is Better)       11693.1
                                                                       AICC (Smaller is Better)      11693.1
                                                                       BIC (Smaller is Better)       11708.5


                                                                          Null Model Likelihood Ratio Test

                                                                            DF    Chi-Square      Pr > ChiSq

                                                                             3       7252.71          <.0001


                                                                            Solution for Fixed Effects

                                                                                        Standard
                                                    Effect                  Estimate       Error      DF    t Value    Pr > |t|

                                                    Intercept                 2.0849     0.04734     334      44.04      <.0001
                                                    adversitymonthly          0.1582     0.01773    6319       8.92      <.0001
                                                    incomec                   0.1071      0.9600     334       0.11      0.9112
                                                    unemployc               -0.01052     0.02516     334      -0.42      0.6761
                                                    greenc                   0.02472     0.08295     334       0.30      0.7659
                                                    rentc                   -0.00133    0.003580     334      -0.37      0.7096
                                                    disorderc                 0.2242      0.1243     334       1.80      0.0722
                                                    cohesionc                -0.1888     0.05842     334      -3.23      0.0014
                                                    womanc                   0.09652     0.09636     334       1.00      0.3173
                                                    agec                    -0.00987     0.01077     334      -0.92      0.3601
                                                    adversitymon*incomec     -0.4978      0.3549    6319      -1.40      0.1608
                                                    adversitym*unemployc    -0.00250    0.009977    6319      -0.25      0.8024
                                                    adversitymonth*rentc    0.000248    0.001358    6319       0.18      0.8550
                                                    adversitymont*greenc     0.04643     0.03978    6319       1.17      0.2432
                                                    adversitym*disorderc      0.1083     0.04796    6319       2.26      0.0239
                                                    adversitym*cohesionc     0.04592     0.02082    6319       2.21      0.0274




;












