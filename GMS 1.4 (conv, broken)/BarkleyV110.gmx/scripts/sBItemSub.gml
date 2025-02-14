//Arg0 is delimited item effect, must call itemuse before
value=real(string_digits(argument0));
effect=string_letters(argument0);
duration='temp';
comm='';

if (string_count("%",argument0)>0) percent=1;
else percent=0;
//Cure ailments
if (string_count("revive",string_lower(argument0))>0) {
comm="sBCondition('revive',0,player)";
} else if (string_count("cure",string_lower(argument0))>0) { //space after efect
effect=string_lower(string_replace(effect,"Cure",""));
if (string_count("ailments",string_lower(argument0))>0) comm="sBCondition('cure','ailments',player)";
else if (string_count("all",string_lower(argument0))>0) comm="sBCondition('cure','all',player)";
else comm="sBCondition('cure',effect,player)";
} else {
effect=string_lower(effect);
}
//Set code for stat modify
if (percent=0) {
if (effect="vp") { comm='sBCondition("vp",value,player);'; }
if (effect="bp") { comm='sBCondition("bp",value,player);'; }
if (effect="power") { comm='global.char_cattack[player]+=value;'; }
if (effect="guard") { comm='global.char_cdefense[player]+=value;'; }
if (effect="speed") { comm='global.char_cfootwork[player]+=value;'; }
if (effect="brain") { comm='global.char_czauberacity[player]+=value;'; }
} else { //percent
if (effect="vp") { comm='sBCondition("vp",floor((player._rvp/100)*value),player);'; }
if (effect="bp") { comm='sBCondition("bp",floor((player._rbp/100)*value),player);'; }
if (effect="power") { comm='global.char_cattack[player]+=(global.char_attack[player]/100)*value;'; }
if (effect="guard") { comm='global.char_cdefense[player]+=(global.char_defense[player]/100)*value;'; }
if (effect="speed") { comm='global.char_cfootwork[player]+=(global.char_footwork[player]/100)*value;'; }
if (effect="brain") { comm='global.char_czauberacity[player]+=(global.char_zauberacity[player]/100)*value;'; }
}
//apply code on objects - ADD DAMAGE OBJECT SHOWING EFFECT
global.temp8=comm;
if (area='single') {
player=who;
execute_string(global.temp8);
} else {
for (playe=0; global.party[playe]!=-1; playe+=1) {
player=global.b_pid[playe];
execute_string(global.temp8);
}
}
//cap all values
sVerifyStats();