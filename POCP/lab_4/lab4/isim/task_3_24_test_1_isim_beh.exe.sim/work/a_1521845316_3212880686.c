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
static const char *ng0 = "C:/Users/andrewyushkevich/Desktop/lab4 - Copy/lab4/task_3_24_bex_1.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_2592010699_sub_2507238156_503743352(char *, unsigned char , unsigned char );


static void work_a_1521845316_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;

LAB0:    xsi_set_current_line(48, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 992U);
    t3 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 3928);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(49, ng0);
    t1 = xsi_get_transient_memory(4U);
    memset(t1, 0, 4U);
    t5 = t1;
    memset(t5, (unsigned char)2, 4U);
    t6 = (t0 + 4040);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 4U);
    xsi_driver_first_trans_delta(t6, 0U, 4U, 0LL);
    goto LAB3;

LAB5:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 1832U);
    t5 = *((char **)t2);
    t2 = (t0 + 4040);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t5, 4U);
    xsi_driver_first_trans_fast(t2);
    goto LAB3;

}

static void work_a_1521845316_3212880686_p_1(char *t0)
{
    char t27[16];
    char t37[16];
    char t47[16];
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned char t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned char t17;
    char *t18;
    char *t19;
    int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned char t24;
    unsigned char t25;
    char *t26;
    char *t28;
    char *t29;
    char *t30;
    int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned char t35;
    char *t36;
    char *t38;
    char *t39;
    char *t40;
    int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned char t45;
    char *t46;
    char *t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned char t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;

LAB0:    xsi_set_current_line(55, ng0);

LAB3:    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = (3 - 0);
    t4 = (t3 * 1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = *((unsigned char *)t1);
    t8 = (t0 + 1352U);
    t9 = *((char **)t8);
    t10 = *((unsigned char *)t9);
    t11 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t7, t10);
    t8 = (t0 + 1672U);
    t12 = *((char **)t8);
    t13 = (0 - 0);
    t14 = (t13 * 1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t8 = (t12 + t16);
    t17 = *((unsigned char *)t8);
    t18 = (t0 + 1672U);
    t19 = *((char **)t18);
    t20 = (3 - 0);
    t21 = (t20 * 1);
    t22 = (1U * t21);
    t23 = (0 + t22);
    t18 = (t19 + t23);
    t24 = *((unsigned char *)t18);
    t25 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t17, t24);
    t28 = ((IEEE_P_2592010699) + 4024);
    t26 = xsi_base_array_concat(t26, t27, t28, (char)99, t11, (char)99, t25, (char)101);
    t29 = (t0 + 1672U);
    t30 = *((char **)t29);
    t31 = (1 - 0);
    t32 = (t31 * 1);
    t33 = (1U * t32);
    t34 = (0 + t33);
    t29 = (t30 + t34);
    t35 = *((unsigned char *)t29);
    t38 = ((IEEE_P_2592010699) + 4024);
    t36 = xsi_base_array_concat(t36, t37, t38, (char)97, t26, t27, (char)99, t35, (char)101);
    t39 = (t0 + 1672U);
    t40 = *((char **)t39);
    t41 = (2 - 0);
    t42 = (t41 * 1);
    t43 = (1U * t42);
    t44 = (0 + t43);
    t39 = (t40 + t44);
    t45 = *((unsigned char *)t39);
    t48 = ((IEEE_P_2592010699) + 4024);
    t46 = xsi_base_array_concat(t46, t47, t48, (char)97, t36, t37, (char)99, t45, (char)101);
    t49 = (1U + 1U);
    t50 = (t49 + 1U);
    t51 = (t50 + 1U);
    t52 = (4U != t51);
    if (t52 == 1)
        goto LAB5;

LAB6:    t53 = (t0 + 4104);
    t54 = (t53 + 56U);
    t55 = *((char **)t54);
    t56 = (t55 + 56U);
    t57 = *((char **)t56);
    memcpy(t57, t46, 4U);
    xsi_driver_first_trans_fast(t53);

LAB2:    t58 = (t0 + 3944);
    *((int *)t58) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(4U, t51, 0);
    goto LAB6;

}

static void work_a_1521845316_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(56, ng0);

LAB3:    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 4168);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 3960);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_1521845316_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1521845316_3212880686_p_0,(void *)work_a_1521845316_3212880686_p_1,(void *)work_a_1521845316_3212880686_p_2};
	xsi_register_didat("work_a_1521845316_3212880686", "isim/task_3_24_test_1_isim_beh.exe.sim/work/a_1521845316_3212880686.didat");
	xsi_register_executes(pe);
}
