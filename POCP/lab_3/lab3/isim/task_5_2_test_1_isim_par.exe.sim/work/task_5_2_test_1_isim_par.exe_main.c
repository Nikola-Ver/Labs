/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *VL_P_2533777724;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000004134447467_2073120511_init();
    simprims_ver_m_00000000003359274523_2662658903_2204449728_init();
    simprims_ver_m_00000000003359274523_2662658903_3561259681_init();
    simprims_ver_m_00000000003359274523_2662658903_3769962234_init();
    simprims_ver_m_00000000001255213976_2021654676_2204449728_init();
    simprims_ver_m_00000000001255213976_2021654676_3561259681_init();
    simprims_ver_m_00000000001255213976_2021654676_3769962234_init();
    simprims_ver_m_00000000001255213976_2021654676_init();
    simprims_ver_u_00000000003032403156_2366604397_init();
    simprims_ver_m_00000000002910948294_0076253249_0174775458_init();
    simprims_ver_m_00000000002910948294_0076253249_3614198996_init();
    simprims_ver_m_00000000003615849920_3100306600_1899403653_init();
    simprims_ver_m_00000000000648012491_3151998091_1305646157_init();
    simprims_ver_m_00000000000648012491_3151998091_2322791993_init();
    simprims_ver_m_00000000001867363923_1692233196_1305646157_init();
    simprims_ver_m_00000000001867363923_1692233196_2322791993_init();
    simprims_ver_m_00000000001255213976_1349438147_4040967982_init();
    simprims_ver_u_00000000002212670773_1323274903_init();
    simprims_ver_m_00000000001160127574_0897309690_3614198996_init();
    simprims_ver_m_00000000000126354981_0818475687_3614198996_init();
    simprims_ver_m_00000000000126354981_0818475687_init();
    work_m_00000000001022703415_0399215979_init();
    ieee_p_2592010699_init();
    vl_p_2533777724_init();
    work_a_3395866771_2372691052_init();


    xsi_register_tops("work_a_3395866771_2372691052");
    xsi_register_tops("work_m_00000000004134447467_2073120511");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    VL_P_2533777724 = xsi_get_engine_memory("vl_p_2533777724");

    return xsi_run_simulation(argc, argv);

}
