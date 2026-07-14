function varargout = saveRun(varargin)
%saveRun Compatibility wrapper for kwsim.io.saveRun.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.io.saveRun directly.

if nargout == 0
    kwsim.io.saveRun(varargin{:});
else
    [varargout{1:nargout}] = kwsim.io.saveRun(varargin{:});
end

end
