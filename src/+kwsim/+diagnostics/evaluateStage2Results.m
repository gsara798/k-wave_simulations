function varargout = evaluateStage2Results(varargin)
%evaluateStage2Results Compatibility wrapper for kwsim.validation.evaluateStage2Results.
%
% This wrapper preserves the original API during the v2 architecture
% migration. New code should call kwsim.validation.evaluateStage2Results directly.

if nargout == 0
    kwsim.validation.evaluateStage2Results(varargin{:});
else
    [varargout{1:nargout}] = kwsim.validation.evaluateStage2Results(varargin{:});
end

end
