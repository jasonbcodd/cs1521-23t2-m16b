#define READING   0x01
#define WRITING   0x02
#define AS_BYTES  0x04
#define AS_BLOCKS 0x08
#define LOCKED    0x10

#include <stdint.h>
#include <stdio.h>


uint8_t printerControl = 0b10100011; // 0b 0000 0000

// Whether the printer is out of ink
#define NO_INK (0x1)       // 0b 0000 0001
// Whether to print/scan in colour
#define COLOUR (0x2)       // 0b 0000 0010
// Select print mode
#define SELECT_PRINT (0x4) // 0b 0000 0100
// Select scan mode
#define SELECT_SCAN (0x8)  // 0b 0000 1000
// Start print/scan
#define START (0x10)       // 0b 0001 0000


void print_if_out_of_ink();
void mark_ink_replaced();


int main() {

}

void print_if_out_of_ink() {
    if ((printerControl & NO_INK) == 0) {
        printf("Printer still has ink!\n");
    } else {
        printf("Printer is out of ink\n");
    }
}

void mark_ink_replaced() {
    printerControl &= ~NO_INK;
}


void scan_colour() {
    printerControl &= ~SELECT_PRINT;
    printerControl |= SELECT_SCAN;
    printerControl |= COLOUR;
}

void toggle_mode() {
    printerControl ^= SELECT_SCAN;
    printerControl ^= SELECT_PRINT;

    if ((printerControl & SELECT_SCAN) == 0) {
        printerControl |= SELECT_SCAN;
        printerControl &= ~SELECT_PRINT;
    } else {
        printerControl &= ~SELECT_SCAN;
        printerControl |= SELECT_PRINT;
    }
}