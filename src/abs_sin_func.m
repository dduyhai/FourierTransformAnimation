function [val, a, b] = abs_sin_func(x, p, fourier_order)
    arguments
        x = []
        p = []
        fourier_order {mustBeInteger, mustBeScalarOrEmpty} = [];
    end
    if ~isempty(fourier_order) && (fourier_order >= 0)
        a = zeros([fourier_order + 1, 1]);
        b = zeros([fourier_order + 1, 1]);
        a(1) = 2 / pi;
        a(3 : 2 : end) = (-4.0 / pi) ./ ((2:2:fourier_order).^2 - 1);
    end
    if isempty(x)
        val = [];
        return;
    end
    val = abs(sin(2 * pi / p * x));
end
