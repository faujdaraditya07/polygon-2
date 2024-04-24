pragma circom 2.0.0;

template AND(input x, input y, output out) {
    out <== x * y;
}

template NOT(input in, output out) {
    out <== 1 - in;
}

template OR(input x, input y, output out) {
    out <== x + y - x * y;
}

template Circuit(input a, input b, output q) {
    signal x;
    signal y;
    AND(a, b, x);
    NOT(b, y);
    OR(x, y, q);
}

component main = Circuit();