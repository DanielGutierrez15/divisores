module div_by_3_50 (
    input clk,      // Reloj de entrada (ej. 100MHz)
    input rst,      // Reset asincrónico para inicializar contadores
    output clk_out  // Reloj de salida (ej. 33.33MHz con 50% duty cycle)
);

    // Registros para los dos contadores de 2 bits (pueden contar hasta 3)
    reg [1:0] pos_count;
    reg [1:0] neg_count;

    // --- Lógica de Flanco de Subida (Posedge) ---
    // Este contador se incrementa cada vez que el reloj original sube.
    always @(posedge clk or posedge rst) begin
        if (rst)
            pos_count <= 2'b00;
        else if (pos_count == 2) // Si llega a 2 (el tercer estado: 0, 1, 2)
            pos_count <= 2'b00;  // Reinicia a 0
        else
            pos_count <= pos_count + 1;
    end

    // --- Lógica de Flanco de Bajada (Negedge) ---
    // Este contador hace exactamente lo mismo, pero "desfasado" medio ciclo
    // porque se activa cuando el reloj original cae.
    always @(negedge clk or posedge rst) begin
        if (rst)
            neg_count <= 2'b00;
        else if (neg_count == 2)
            neg_count <= 2'b00;
        else
            neg_count <= neg_count + 1;
    end

    // --- Generación de la Salida ---
    // Usamos el bit 1 de ambos contadores. 
    // El bit 1 de pos_count está en '1' durante 1/3 del ciclo total.
    // Al hacer un OR con el de neg_count (que viene medio ciclo después),
    // "estiramos" ese pulso para que dure exactamente 1.5 ciclos de clk.
    assign clk_out = (pos_count[1] | neg_count[1]);

endmodule
