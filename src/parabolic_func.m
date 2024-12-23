function [val, a, b] = parabolic_func(x, p, fourier_order)
    arguments
        x = []
        p = []
        fourier_order {mustBeInteger, mustBeScalarOrEmpty} = [];
    end
    f
    end
    if ~isempty(fourier_order) && (fourier_order >= 0)
        a = zeros([fourier_order + 1, 1]);
        b = zeros([fourier_order + 1, 1]);
        a(1) = 1.0 / 3.0;
        if (fourier_order >= 1)
            n = (1:fourier_order).';
            a(2:end) = (4.0/pi^2) ./ n.^2;
        end
    end
    if isempty(x)
        val = [];
        return;
    end
    x = x - floor(x / p) * p;
    val = (4.0 / p^2) * (x - 0.5 * p).^2;
end
