function varargout = fitHarmonic(varargin)
%FITHARMONIC Compatibility wrapper for kwsim.signal.fitHarmonic.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.signal.fitHarmonic directly.

if nargout == 0
    kwsim.signal.fitHarmonic(varargin{:});
else
    [varargout{1:nargout}] = kwsim.signal.fitHarmonic(varargin{:});
end

end
