function varargout = locateKWave(varargin)
%locateKWave Compatibility wrapper for kwsim.io.locateKWave.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.io.locateKWave directly.

if nargout == 0
    kwsim.io.locateKWave(varargin{:});
else
    [varargout{1:nargout}] = kwsim.io.locateKWave(varargin{:});
end

end
