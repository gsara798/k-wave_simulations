function varargout = evaluateStage3Results(varargin)
%evaluateStage3Results Compatibility wrapper for kwsim.validation.evaluateStage3Results.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.validation.evaluateStage3Results directly.

if nargout == 0
    kwsim.validation.evaluateStage3Results(varargin{:});
else
    [varargout{1:nargout}] = kwsim.validation.evaluateStage3Results(varargin{:});
end

end
