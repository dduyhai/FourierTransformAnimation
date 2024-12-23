function [val, a, b] = sawtooth_func(x, p, fourier_order)
    arguments
        x = []
        p = []
        fourier_order {mustBeInteger, mustBeScalarOrEmpty} = [];
    end
    if ~isempty(fourier_order) && (fourier_order >= 0)
        a = zeros([fourier_order + 1, 1]);
        b = zeros([fourier_order + 1, 1]);
        a(1) = 0.5;
        if (fourier_order >= 1)
            n = (1:fourier_order);
            b(2:end) = (-1.0 / pi) ./ n;
        end
    end
    if isempty(x)
        val = [];
        return;
    end
    x = x - floor(x / p) * p;
    val = x / p;
end
