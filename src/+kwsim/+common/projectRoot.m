function varargout = projectRoot(varargin)
%projectRoot Compatibility wrapper for kwsim.io.projectRoot.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.io.projectRoot directly.

if nargout == 0
    kwsim.io.projectRoot(varargin{:});
else
    [varargout{1:nargout}] = kwsim.io.projectRoot(varargin{:});
end

end
