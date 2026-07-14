function varargout = evaluateStage4Sweep(varargin)
%evaluateStage4Sweep Compatibility wrapper for kwsim.validation.evaluateStage4Sweep.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.validation.evaluateStage4Sweep directly.

if nargout == 0
    kwsim.validation.evaluateStage4Sweep(varargin{:});
else
    [varargout{1:nargout}] = kwsim.validation.evaluateStage4Sweep(varargin{:});
end

end
