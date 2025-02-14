//Id of player, value, effect, duration
//add percent
//cures condition global.char_res2[]
//get minus
//do all
//maker sure conditions heal on all
//Hustle, Zaubered, Diabetes, Glaucoma, Muscled, Time Out
//cap values
//area is grabbed before
value=real(string_digits(argument0));
effect=string_letters(argument0);
if (string_count("permanent",string_lower(effect))>0) {
duration='permanent';
effect=string_replace(effect,"Permanent",'');
} else duration='temp';
comm='';
if (string_count("%",argument0)>0) percent=1;
else percent=0;
if (string_count("revive",string_lower(argument0))>0) {
comm="global.char_chp[player]=max(global.char_chp[player],1);";
} else if (string_count("cure",string_lower(argument0))>0) { //space after efect
effect=string_replace(effect,"Cure",""); //had string lower
if (string_count("ailments",string_lower(argument0))>0) comm="x=x;";
else if (string_count("all",string_lower(argument0))>0) comm="global.char_res2[player]=''";
else comm="global.char_res2[player]=string_replace(global.char_res2[player],effect+' ','')";
} else {
effect=string_lower(effect);
}
if (duration="permanent") {
if (effect="vp") { comm='global.char_hp[player]+=value; if (global.char_chp[player]>0) global.char_chp[player]+=value;'; }
if (effect="bp") { comm='global.char_zp[player]+=value; global.char_czp[player]+=value;'; }
if (effect="power") { comm='global.char_attack[player]+=value;'; }
if (effect="guard") { comm='global.char_defense[player]+=value;'; }
if (effect="speed") { comm='global.char_footwork[player]+=value;'; }
if (effect="brain") { comm='global.char_zauberacity[player]+=value;'; }
} else { //temporary diration
if (percent=0) {
if (effect="vp") { comm='if (global.char_chp[player]>0) global.char_chp[player]+=value;'; }
if (effect="bp") { comm='global.char_czp[player]+=value;'; }
if (effect="power") { comm='global.char_cattack[player]+=value;'; }
if (effect="guard") { comm='global.char_cdefense[player]+=value;'; }
if (effect="speed") { comm='global.char_cfootwork[player]+=value;'; }
if (effect="brain") { comm='global.char_czauberacity[player]+=value;'; }
} else { //percent
if (effect="vp") { comm='if (global.char_chp[player]>0) global.char_chp[player]+=floor((global.char_hp[player]/100)*value);'; }
if (effect="bp") { comm='global.char_czp[player]+=floor((global.char_zp[player]/100)*value);'; }
if (effect="power") { comm='global.char_cattack[player]+=floor(global.char_attack[player]/100)*value;'; }
if (effect="guard") { comm='global.char_cdefense[player]+=floor(global.char_defense[player]/100)*value;'; }
if (effect="speed") { comm='global.char_cfootwork[player]+=floor(global.char_footwork[player]/100)*value;'; }
if (effect="brain") { comm='global.char_czauberacity[player]+=floor(global.char_zauberacity[player]/100)*value;'; }
}
}

//One or all
if (area='single') {
player=who;
execute_string(comm);
} else {
for (playe=0; global.party[playe]!=-1; playe+=1) {
player=global.party[playe];
execute_string(comm);
}
}

//cap all values
for (playe=0; global.party[playe]!=-1; playe+=1) {
player=global.party[playe];
global.char_chp[player]=min(global.char_hp[player],global.char_chp[player]);
global.char_czp[player]=min(global.char_zp[player],global.char_czp[player]);
if (false) { //battle
global.char_cattack[player]=min(global.char_attack[player],global.char_cattack[player]);
global.char_cdefense[player]=min(global.char_defense[player],global.char_cdefense[player]);
global.char_cfootwork[player]=min(global.char_footwork[player],global.char_cfootwork[player]);
global.char_czauberacity[player]=min(global.char_zauberacity[player],global.char_czauberacity[player]);
}
}