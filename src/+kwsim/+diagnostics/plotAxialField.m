function varargout = plotAxialField(varargin)
%plotAxialField Compatibility wrapper for kwsim.viz.plotAxialField.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.viz.plotAxialField directly.

if nargout == 0
    kwsim.viz.plotAxialField(varargin{:});
else
    [varargout{1:nargout}] = kwsim.viz.plotAxialField(varargin{:});
end

end
