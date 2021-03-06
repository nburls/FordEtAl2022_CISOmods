#!/bin/csh -f

#------------------------------------------------------------------------------------
# For now, set streams manually. You must only set as many streams as are declared
#  in the tavg_nml section. For example, if there are three streams:
#  @ s1 = $my_stream
#  @ s2 = $s1 + 1
#  @ s3 = $s2 + 1
#------------------------------------------------------------------------------------

@ my_stream = $1
if ($my_stream < 1) then
   echo invalid my_stream number  ($my_stream)
   exit 5
endif

@ s1 = 1             # use the base-model stream 1

cat >! $CASEROOT/Buildconf/pop2conf/ciso_tavg_contents << EOF
#$s1  CISO_DO13C_RIV_FLUX
#$s1  CISO_DI13C_RIV_FLUX
$s1  CISO_zooC_d13C       
$s1  CISO_DOC_d13C         
$s1  CISO_DIC_d13C           
$s1  CISO_FG_13CO2
$s1  CISO_FG_as_13CO2
$s1  CISO_FG_sa_13CO2
$s1  CISO_FG_d13C
$s1  CISO_D13C_atm
$s1  CISO_R13C_DIC_surf
$s1  CISO_R13C_atm
$s1  CISO_eps_aq_g_surf
$s1  CISO_eps_dic_g_surf
$s1  CISO_eps_aq_g
$s1  CISO_eps_dic_g
$s1  CISO_PO13C_FLUX_IN
$s1  CISO_PO13C_PROD
$s1  CISO_PO13C_REMIN
$s1  CISO_DO13C_prod
$s1  CISO_DO13C_remin
$s1  CISO_Ca13CO3_FLUX_IN
$s1  CISO_Ca13CO3_PROD
$s1  CISO_Ca13CO3_REMIN
$s1  CISO_photo13C_TOT
#$s1  CISO_photo13C_TOT_zint
$s1  CISO_Jint_13Ctot
#$s1  CISO_Jint_100m_13Ctot
$s1  calcToSed_13C
$s1  pocToSed_13C
#$s1  FvPER_DI13C
#$s1  FvICE_DI13C
$s1  DI13C
#$s1  J_DI13C
$s1  DO13C
$s1  zoo13C
#$s1  Jint_100m_DI13C
#$s1  Jint_100m_DO13C
#$s1  tend_zint_100m_DI13C
#$s1  tend_zint_100m_DO13C
EOF

# generic autotroph fields
foreach autotroph ( sp diat diaz )
   cat >> $CASEROOT/Buildconf/pop2conf/ciso_tavg_contents << EOF
$s1  CISO_d13C_${autotroph}
$s1  CISO_photo13C_${autotroph}
$s1  CISO_photo13C_${autotroph}_zint
$s1  ${autotroph}13C
#$s1  CISO_mui_to_co2star_${autotroph}
#$s1  CISO_eps_autotroph_${autotroph}
EOF
end
 
 
# CaCO3 terms from calcifiers 
foreach autotroph ( sp )
   cat >> $CASEROOT/Buildconf/pop2conf/ciso_tavg_contents << EOF
$s1  CISO_autotrophCaCO3_d13C_${autotroph}
$s1  CISO_${autotroph}_Ca13CO3_form
#$s1  CISO_${autotroph}_Ca13CO3_form_zint
$s1  ${autotroph}Ca13CO3
EOF
end
 
   


