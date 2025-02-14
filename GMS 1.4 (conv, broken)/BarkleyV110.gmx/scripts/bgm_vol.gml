if (argument0<=-1)
  return bgm_GetAttr(0,"cvolume")
else
  return bgm_SetAttr(0,"cvolume", argument0);