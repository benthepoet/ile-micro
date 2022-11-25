    .MEMORYMAP
    SLOTSIZE $8000
    DEFAULTSLOT 0
    SLOT 0 $0000
    .ENDME

    .ROMBANKMAP
    BANKSTOTAL 1
    BANKSIZE $8000
    BANKS 1
    .ENDRO
    
    .BANK 0 SLOT 0
    .ORGA $0000

    kb_bf = $8000
    kb_rd = $8100
    kb_wr = $8101

    vdp_data = $BE
    vdp_reg = $BF
    
    jr main

vbl:    
    .org $0038
    in a,(vdp_reg)
    ei
    reti
    
main:
    di
    im 1
    
    ld bc,$0200
    call set_reg

    ld bc,$e201
    call set_reg

    ld bc,$0e02
    call set_reg

    ld bc,$9f03
    call set_reg

    ld bc,$0004
    call set_reg

    ld bc,$7605
    call set_reg

    ld bc,$0306
    call set_reg
    
    ld bc,$0407
    call set_reg
    
    ei
    
loop:
    di
    ld bc,kb_rd
    ld a,b
pull_key:   
    cp c
    inc a
    jr nz,pull_key
    ei
    halt
    jr loop
    
set_reg:
    push af
    ld a,b
    out (vdp_reg),a
    ld a,$80
    or c
    out (vdp_reg),a
    pop af
    ret

set_addr:
    push af
    push hl
    ld hl,vdp_reg
    ld (hl),b
    ld a,$40
    or c
    ld (hl),a
    pop hl
    pop af
    ret
