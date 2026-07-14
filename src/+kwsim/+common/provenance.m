function varargout = provenance(varargin)
%provenance Compatibility wrapper for kwsim.io.provenance.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.io.provenance directly.

if nargout == 0
    kwsim.io.provenance(varargin{:});
else
    [varargout{1:nargout}] = kwsim.io.provenance(varargin{:});
end

end
