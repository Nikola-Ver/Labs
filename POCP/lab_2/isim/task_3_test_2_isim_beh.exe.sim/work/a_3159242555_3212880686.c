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

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/Programming/University/pocp/lab_2/task_3_bex_2.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1605435078_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_1690584930_503743352(char *, unsigned char );
unsigned char ieee_p_2592010699_sub_2545490612_503743352(char *, unsigned char , unsigned char );


static void work_a_3159242555_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    unsigned char t13;
    unsigned char t14;
    char *t15;
    unsigned char t16;
    unsigned char t17;
    unsigned char t18;
    char *t19;
    unsigned char t20;
    char *t21;
    unsigned char t22;
    unsigned char t23;
    unsigned char t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;

LAB0:    xsi_set_current_line(43, ng0);

LAB3:    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 1192U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t6 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t5);
    t7 = ieee_p_2592010699_sub_2545490612_503743352(IEEE_P_2592010699, t3, t6);
    t1 = (t0 + 1352U);
    t8 = *((char **)t1);
    t9 = *((unsigned char *)t8);
    t10 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t9);
    t11 = ieee_p_2592010699_sub_2545490612_503743352(IEEE_P_2592010699, t7, t10);
    t1 = (t0 + 1032U);
    t12 = *((char **)t1);
    t13 = *((unsigned char *)t12);
    t14 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t13);
    t1 = (t0 + 1352U);
    t15 = *((char **)t1);
    t16 = *((unsigned char *)t15);
    t17 = ieee_p_2592010699_sub_2545490612_503743352(IEEE_P_2592010699, t14, t16);
    t18 = ieee_p_2592010699_sub_1605435078_503743352(IEEE_P_2592010699, t11, t17);
    t1 = (t0 + 1192U);
    t19 = *((char **)t1);
    t20 = *((unsigned char *)t19);
    t1 = (t0 + 1352U);
    t21 = *((char **)t1);
    t22 = *((unsigned char *)t21);
    t23 = ieee_p_2592010699_sub_2545490612_503743352(IEEE_P_2592010699, t20, t22);
    t24 = ieee_p_2592010699_sub_1605435078_503743352(IEEE_P_2592010699, t18, t23);
    t1 = (t0 + 3072);
    t25 = (t1 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    *((unsigned char *)t28) = t24;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t29 = (t0 + 2992);
    *((int *)t29) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_3159242555_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3159242555_3212880686_p_0};
	xsi_register_didat("work_a_3159242555_3212880686", "isim/task_3_test_2_isim_beh.exe.sim/work/a_3159242555_3212880686.didat");
	xsi_register_executes(pe);
}
