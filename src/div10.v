// Módulo que implementa un divisor de frecuencia por 10
// La señal de salida tendrá una frecuencia 10 veces menor que la de entrada
// y un ciclo útil (duty cycle) aproximado del 50%.
module div_by_10 (
    input clk,        // Señal de reloj de entrada
    input rst,        // Señal de reset asincrónico (activo en alto)
    output reg clk_out // Señal de reloj dividida (salida)
);

// Registro contador de 4 bits
// Se usa para contar los ciclos del reloj de entrada.
// 4 bits permiten contar hasta 15, pero aquí solo se usa hasta 9.
reg [3:0] count;


// Bloque secuencial que se ejecuta en:
// - el flanco positivo del reloj (posedge clk)
// - o cuando ocurre un reset (posedge rst)
always @(posedge clk or posedge rst) begin

    // Si el reset se activa
    if (rst) begin
        
        // Se reinicia el contador a 0
        count <= 0;
        
        // La salida también se pone en 0
        clk_out <= 0;
    end 
    
    // Si no hay reset
    else begin

        // Implementación del contador módulo 10
        // Cuando el contador llega a 9 vuelve a 0
        if (count == 9)
            count <= 0;
        else
            // En otro caso simplemente incrementa en 1
            count <= count + 1;

        // Control del ciclo útil (duty cycle)

        // Cuando el contador llega a 4
        // se coloca la salida en nivel alto.
        // Esto ocurre después de 5 ciclos de reloj (0,1,2,3,4)
        if (count == 4)
            clk_out <= 1;

        // Cuando el contador llega a 9
        // la salida vuelve a nivel bajo.
        // Así se completan otros 5 ciclos (5,6,7,8,9)
        if (count == 9)
            clk_out <= 0;

    end
end

endmodule
