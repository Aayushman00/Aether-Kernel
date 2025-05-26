void kernel_main() {
    const char *str = "Welcome to My Simple OS!";
    char *video = (char*)0xb8000;

    for (int i = 0; str[i] != '\0'; i++) {
        video[i * 2] = str[i];       // Character
        video[i * 2 + 1] = 0x07;     // Color
    }

    while (1); // Infinite loop
}
