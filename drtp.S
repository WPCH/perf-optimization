/*
 *  based on linux/arch/arm/lib/memcpy.S
 */

#define PLD(code...)    code
#define CALGN(code...)
#define W(instr)    instr
#define pull            lsr
#define push            lsl

#define __ALIGN .align 0
#define ALIGN __ALIGN

#ifndef ENTRY
#define ENTRY(name) \
  .globl name; \
  ALIGN; \
  name:
#endif

#ifndef END
#define END(name) \
  .size name, .-name
#endif

#ifndef ENDPROC
#define ENDPROC(name) \
  .type name, %function; \
  END(name)
#endif


#define LDR1W_SHIFT	0
#define STR1W_SHIFT	0

	.macro ldr1w ptr reg abort
	W(ldr) \reg, [\ptr], #4
	.endm

	.macro ldr4w ptr reg1 reg2 reg3 reg4 abort
	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4}
	.endm

	.macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
	.endm

	.macro ldr1b ptr reg cond=al abort
	ldr\cond\()b \reg, [\ptr], #1
	.endm

	.macro str1w ptr reg abort
	W(str) \reg, [\ptr], #4
	.endm

	.macro str2w ptr reg1 reg2 abort
	stmia \ptr!, {\reg1, \reg2}
	.endm

	.macro str3w ptr reg1 reg2 reg3 abort
	stmia \ptr!, {\reg1, \reg2, \reg3}
	.endm

	.macro str4w ptr reg1 reg2 reg3 reg4 abort
	stmia \ptr!, {\reg1, \reg2, \reg3, \reg4}
	.endm

	.macro str5w ptr reg1 reg2 reg3 reg4 reg5 abort
	stmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5}
	.endm

	.macro str6w ptr reg1 reg2 reg3 reg4 reg5 reg6 abort
	stmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6}
	.endm

	.macro str7w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 abort
	stmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7}
	.endm

	.macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
	stmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
	.endm

	.macro str1wc ptr reg cond=al abort
	str\cond\() \reg, [\ptr], #4
	.endm

	.macro str2wc ptr reg1 reg2 cond=al abort
	stm\cond\()ia \ptr!, {\reg1, \reg2}
	.endm

	.macro str3wc ptr reg1 reg2 reg3 cond=al abort
	stm\cond\()ia \ptr!, {\reg1, \reg2, \reg3}
	.endm

	.macro str4wc ptr reg1 reg2 reg3 reg4 cond=al abort
	stm\cond\()ia \ptr!, {\reg1, \reg2, \reg3, \reg4}
	.endm

	.macro str5wc ptr reg1 reg2 reg3 reg4 reg5 cond=al abort
	stm\cond\()ia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5}
	.endm

	.macro str6wc ptr reg1 reg2 reg3 reg4 reg5 reg6 cond=al abort
	stm\cond\()ia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6}
	.endm

	.macro str7wc ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 cond=al abort
	stm\cond\()ia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7}
	.endm

	.macro str8wc ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 cond=al abort
	stm\cond\()ia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
	.endm

	.macro str1b ptr reg cond=al abort
	str\cond\()b \reg, [\ptr], #1
	.endm

	.macro enter reg1 reg2
	stmdb sp!, {r0, \reg1, \reg2}
	.endm

	.macro exit reg1 reg2
	ldmfd sp!, {r0, \reg1, \reg2}
	.endm

	.macro proc1w reg
	ands    r10, r11, \reg
	strneh  r10, [r0], #2
	addeq	r0, r0, #2
	ands    r10, r11, \reg, lsr #16
	strneh  r10, [r0], #2
	addeq	r0, r0, #2
	.endm

	.macro proc_data reg1 reg2 reg3
		mov     \reg1, #0

		ands    r10, r3, r3, lsl #16
		beq     30f
		ands    r10, r4, r4, lsl #16
		beq		31f
		ands    r10, r5, r5, lsl #16
		beq		32f
		ands    r10, r6, r6, lsl #16
		beq		33f
		ands    r10, r7, r7, lsl #16
		beq		34f
		ands    r10, r8, r8, lsl #16
		beq		35f
		ands    r10, \reg2, \reg2, lsl #16
		beq		36f
		ands    r10, \reg3, \reg3, lsl #16
		beq		37f
		str8w	r0, r3, r4, r5, r6, r7, r8, \reg2, \reg3, abort=20f
		b		100f

		
60:		ands    r10, r4, r4, lsl #16
		beq		31f
		ands    r10, r5, r5, lsl #16
		beq		32f
		ands    r10, r6, r6, lsl #16
		beq		33f
		ands    r10, r7, r7, lsl #16
		beq		34f
		ands    r10, r8, r8, lsl #16
		beq		35f
		ands    r10, \reg2, \reg2, lsl #16
		beq		36f
		ands    r10, \reg3, \reg3, lsl #16
		beq		37f
		str7w	r0, r4, r5, r6, r7, r8, \reg2, \reg3, abort=20f
		b		100f

61:		ands    r10, r5, r5, lsl #16
		beq		32f
		ands    r10, r6, r6, lsl #16
		beq		33f
		ands    r10, r7, r7, lsl #16
		beq		34f
		ands    r10, r8, r8, lsl #16
		beq		35f
		ands    r10, \reg2, \reg2, lsl #16
		beq		36f
		ands    r10, \reg3, \reg3, lsl #16
		beq		37f
		str6w	r0, r5, r6, r7, r8, \reg2, \reg3, abort=20f
		b		100f


62:		ands    r10, r6, r6, lsl #16
		beq		33f
		ands    r10, r7, r7, lsl #16
		beq		34f
		ands    r10, r8, r8, lsl #16
		beq		35f
		ands    r10, \reg2, \reg2, lsl #16
		beq		36f
		ands    r10, \reg3, \reg3, lsl #16
		beq		37f
		str5w	r0, r6, r7, r8, \reg2, \reg3, abort=20f
		b		100f

63:		ands    r10, r7, r7, lsl #16
		beq		34f
		ands    r10, r8, r8, lsl #16
		beq		35f
		ands    r10, \reg2, \reg2, lsl #16
		beq		36f
		ands    r10, \reg3, \reg3, lsl #16
		beq		37f
		str4w	r0, r7, r8, \reg2, \reg3, abort=20f
		b		100f

64:		ands    r10, r8, r8, lsl #16
		beq		35f
		ands    r10, \reg2, \reg2, lsl #16
		beq		36f
		ands    r10, \reg3, \reg3, lsl #16
		beq		37f
		str3w	r0, r8, \reg2, \reg3, abort=20f
		b		100f

65:		ands    r10, \reg2, \reg2, lsl #16
		beq		36f
		ands    r10, \reg3, \reg3, lsl #16
		beq		37f
		str2w	r0, \reg2, \reg3, abort=20f
		b		100f

66:		ands    r10, \reg3, \reg3, lsl #16
		beq		37f
		str1w	r0,  \reg3, abort=20f
		b		100f


30:		proc1w	r3
		add		\reg1, \reg1, #1
		b		60b

		
31:		cmp 	\reg1, #0
		str1wc	r0, r3, eq, abort=20f
		addeq	\reg1, \reg1, #1

		proc1w	r4
		add		\reg1, \reg1, #1
		b		61b

32:		cmp 	\reg1, #0
		str2wc	r0, r3, r4, eq, abort=20f
		addeq	\reg1, \reg1, #2
		beq     320f
		cmp		\reg1, #1
		str1wc	r0, r4, eq, abort=20f
		addeq	\reg1, \reg1, #1

320:	proc1w	r5
		add		\reg1, \reg1, #1
		b		62b

33:		cmp 	\reg1, #0
		str3wc	r0, r3, r4, r5, eq, abort=20f
		addeq	\reg1, \reg1, #3
		beq     330f
		cmp		\reg1, #1
		str2wc	r0, r4, r5, eq, abort=20f
		addeq	\reg1, \reg1, #2
		beq     330f
		cmp		\reg1, #2
		str1wc	r0, r5, eq, abort=20f
		addeq	\reg1, \reg1, #1

330:	proc1w	r6
		add		\reg1, \reg1, #1
		b		63b

34:		cmp 	\reg1, #0
		str4wc	r0, r3, r4, r5, r6, eq, abort=20f
		addeq   \reg1, \reg1, #4
		beq     340f
		cmp		\reg1, #1
		str3wc	r0, r4, r5, r6, eq, abort=20f
		addeq	\reg1, \reg1, #3
		beq     340f
		cmp		\reg1, #2
		str2wc	r0, r5, r6, eq, abort=20f
		addeq	\reg1, \reg1, #2
		beq     340f
		cmp		\reg1, #3
		str1wc	r0, r6, eq, abort=20f
		addeq	\reg1, \reg1, #1

340:	proc1w	r7
		add		\reg1, \reg1, #1
		b		64b

35:		cmp 	\reg1, #0
		str5wc	r0, r3, r4, r5, r6, r7, eq, abort=20f
		addeq	\reg1, \reg1, #5
		beq     350f
		cmp 	\reg1, #1
		str4wc	r0, r4, r5, r6, r7, eq, abort=20f
		addeq	\reg1, \reg1, #4
		beq     350f
		cmp		\reg1, #2
		str3wc	r0, r5, r6, r7, eq, abort=20f
		addeq	\reg1, \reg1, #3
		beq     350f
		cmp		\reg1, #3
		str2wc	r0, r6, r7, eq, abort=20f
		addeq	\reg1, \reg1, #2
		beq     350f
		cmp		\reg1, #4
		str1wc	r0, r7, eq, abort=20f
		addeq	\reg1, \reg1, #1

350:	proc1w	r8
		add		\reg1, \reg1, #1
		b		65b

36:		cmp 	\reg1, #0
		str6wc	r0, r3, r4, r5, r6, r7, r8, eq, abort=20f
		addeq	\reg1, \reg1, #6
		beq     360f
		cmp 	\reg1, #1
		str5wc	r0, r4, r5, r6, r7, r8, eq, abort=20f
		addeq	\reg1, \reg1, #5
		beq     360f
		cmp 	\reg1, #2
		str4wc	r0, r5, r6, r7, r8, eq, abort=20f
		addeq	\reg1, \reg1, #4
		beq     360f
		cmp		\reg1, #3
		str3wc	r0, r6, r7, r8, eq, abort=20f
		addeq	\reg1, \reg1, #3
		beq     360f
		cmp		\reg1, #4
		str2wc	r0, r7, r8, eq, abort=20f
		addeq	\reg1, \reg1, #2
		beq     360f
		cmp		\reg1, #5
		str1wc	r0, r8, eq, abort=20f
		addeq	\reg1, \reg1, #1

360:	proc1w	\reg2
		add		\reg1, \reg1, #1
		b		66b

37:		cmp 	\reg1, #0
		str7wc	r0, r3, r4, r5, r6, r7, r8, \reg2, eq, abort=20f
		addeq	\reg1, \reg1, #7
		beq     370f
		cmp 	\reg1, #1
		str6wc	r0, r4, r5, r6, r7, r8, \reg2, eq, abort=20f
		addeq	\reg1, \reg1, #6
		beq     370f
		cmp 	\reg1, #2
		str5wc	r0, r5, r6, r7, r8, \reg2, eq, abort=20f
		addeq	\reg1, \reg1, #5
		beq     370f
		cmp 	\reg1, #3
		str4wc	r0, r6, r7, r8, \reg2, eq, abort=20f
		addeq	\reg1, \reg1, #4
		beq     370f
		cmp		\reg1, #4
		str3wc	r0, r7, r8, \reg2, eq, abort=20f
		addeq	\reg1, \reg1, #3
		beq     370f
		cmp		\reg1, #5
		str2wc	r0, r8, \reg2, eq, abort=20f
		addeq	\reg1, \reg1, #2
		beq     370f
		cmp		\reg1, #6
		str1wc	r0, \reg2, eq, abort=20f
		addeq	\reg1, \reg1, #1

370:	proc1w	\reg3

100:	nop
	.endm

	.text

/* Prototype: void *drtp(unsigned short *dest, unsigned short *src, int n); */

ENTRY(drtp)


		enter	r4, lr
		stmfd	sp!, {r10 - r11}
		add		r2, r2, r2

		mov   r11, #255
		orr	r11, r11, r11, lsl #8
		subs	r2, r2, #4
		blt	8f
		ands	ip, r0, #3
	PLD(	pld	[r1, #0]		)
		bne	9f
		ands	ip, r1, #3
		bne	10f

1:		subs	r2, r2, #(28)
		stmfd	sp!, {r5 - r9}
		blt	5f

	CALGN(	ands	ip, r0, #31		)
	CALGN(	rsb	r3, ip, #32		)
	CALGN(	sbcnes	r4, r3, r2		)  @ C is always set here
	CALGN(	bcs	2f			)
	CALGN(	adr	r4, 6f			)
	CALGN(	subs	r2, r2, r3		)  @ C gets set
	CALGN(	add	pc, r4, ip		)

	PLD(	pld	[r1, #0]		)
2:	PLD(	subs	r2, r2, #96		)
	PLD(	pld	[r1, #28]		)
	PLD(	blt	4f			)
	PLD(	pld	[r1, #60]		)
	PLD(	pld	[r1, #92]		)

3:	PLD(	pld	[r1, #124]		)
4:		ldr8w	r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f

		proc_data r9 ip lr

		subs	r2, r2, #32
		bge	3b
	PLD(	cmn	r2, #96			)
	PLD(	bge	4b			)

5:		ands	ip, r2, #28
		rsb	ip, ip, #32
#if LDR1W_SHIFT > 0
		lsl	ip, ip, #LDR1W_SHIFT
#endif
		addne	pc, pc, ip		@ C is always clear here
		b	7f
6:
		.rept	(1 << LDR1W_SHIFT)
		W(nop)
		.endr
		ldr1w	r1, r3, abort=20f
		ldr1w	r1, r4, abort=20f
		ldr1w	r1, r5, abort=20f
		ldr1w	r1, r6, abort=20f
		ldr1w	r1, r7, abort=20f
		ldr1w	r1, r8, abort=20f
		ldr1w	r1, lr, abort=20f

#if LDR1W_SHIFT < STR1W_SHIFT
		lsl	ip, ip, #STR1W_SHIFT - LDR1W_SHIFT
#elif LDR1W_SHIFT > STR1W_SHIFT
		lsr	ip, ip, #LDR1W_SHIFT - STR1W_SHIFT
#endif

		add	pc, pc, ip
		nop
		.rept	(1 << STR1W_SHIFT)
		W(nop)
		.endr

		b	63f
		b	64f
		b	65f
		b	66f
		b	67f
		b	68f
		b	69f

63:		proc1w  r3
64:		proc1w  r4
65:		proc1w  r5
66:		proc1w  r6
67:		proc1w  r7
68:		proc1w  r8
69:		proc1w  lr

	CALGN(	bcs	2b			)

7:		ldmfd	sp!, {r5 - r9}

8:		movs	r2, r2, lsl #31
		bcc     25f
		ldrh    r3, [r1], #2
		cmp r3, #0
		strneh  r3, [r0]
		add		r0, r0, #2

25:		ldmfd	sp!, {r10 - r11}
		exit	r4, pc

9:		rsb	ip, ip, #4
		ldrh    r3, [r1], #2
		cmp r3, #0
		strneh  r3, [r0], #2
		addeq	r0, r0, #2
		subs	r2, r2, ip
		blt	8b
		ands	ip, r1, #3
		beq	1b

10:		bic	r1, r1, #3
		cmp	ip, #2
		ldr1w	r1, lr, abort=21f
		beq	17f
		bgt	18f


		.macro	forward_copy_shift pull push

		subs	r2, r2, #28
		blt	14f

	CALGN(	ands	ip, r0, #31		)
	CALGN(	rsb	ip, ip, #32		)
	CALGN(	sbcnes	r4, ip, r2		)  @ C is always set here
	CALGN(	subcc	r2, r2, ip		)
	CALGN(	bcc	15f			)

11:		stmfd	sp!, {r5 - r9}

	PLD(	pld	[r1, #0]		)
	PLD(	subs	r2, r2, #96		)
	PLD(	pld	[r1, #28]		)
	PLD(	blt	13f			)
	PLD(	pld	[r1, #60]		)
	PLD(	pld	[r1, #92]		)

12:	PLD(	pld	[r1, #124]		)
13:		ldr4w	r1, r4, r5, r6, r7, abort=19f
		mov	r3, lr, pull #\pull
		ldr4w	r1, r8, r9, ip, lr, abort=19f
		orr	r3, r3, r4, push #\push
		mov	r4, r4, pull #\pull
		orr	r4, r4, r5, push #\push
		mov	r5, r5, pull #\pull
		orr	r5, r5, r6, push #\push
		mov	r6, r6, pull #\pull
		orr	r6, r6, r7, push #\push
		mov	r7, r7, pull #\pull
		orr	r7, r7, r8, push #\push
		mov	r8, r8, pull #\pull
		orr	r8, r8, r9, push #\push
		mov	r9, r9, pull #\pull
		orr	r9, r9, ip, push #\push
		mov	ip, ip, pull #\pull
		orr	ip, ip, lr, push #\push

		stmfd	sp!, {lr}
		proc_data lr r9 ip
		ldmfd	sp!, {lr}

		subs	r2, r2, #32
		bge	12b
	PLD(	cmn	r2, #96			)
	PLD(	bge	13b			)

		ldmfd	sp!, {r5 - r9}

14:		ands	ip, r2, #28
		beq	16f

15:		mov	r3, lr, pull #\pull
		ldr1w	r1, lr, abort=21f
		orr	r3, r3, lr, push #\push

		proc1w	r3

		subs	ip, ip, #4
		bgt	15b
	CALGN(	cmp	r2, #0			)
	CALGN(	bge	11b			)

16:		sub	r1, r1, #(\push / 8)
		b	8b

		.endm



		forward_copy_shift	pull=8	push=24

17:		forward_copy_shift	pull=16	push=16

18:		forward_copy_shift	pull=24	push=8


/*
 * Abort preamble and completion macros.
 * If a fixup handler is required then those macros must surround it.
 * It is assumed that the fixup code will handle the private part of
 * the exit macro.
 */

	.macro	copy_abort_preamble
19:	ldmfd	sp!, {r5 - r9}
	b	21f
20:	ldmfd	sp!, {r5 - r8}
21:
	.endm

	.macro	copy_abort_end
	ldmfd	sp!, {r4, pc}
	.endm

