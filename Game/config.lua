application =
{
	content =
	{
		--graphicsCompatibility = 1;
		fps = 30,			-- Desired frame rate 
		width = 320,		-- Desired width of the application
		height = 480,		-- Desired height of the application
   		---specify the audioPlayFrequency parameter. This optimization hint prompts OpenAL to mix/play at a specific frequency.	
		-- Scaling mode, should the screen not fit the width and height exactly
		scale = "zoomStretch",

		--[[
		Other options include:
		"none"			no dynamic content scaling
		"letterbox"		uniform scaling of content with black bars surrounding content
		"zoomEven"		scaling of content to fill screen while preserving aspect ratio (some content may be offscreen)
		"zoomStretch"	scaling of content to fill screen by stretching to fit height and width (results in distorted imagery)
		--]]
		
		--Suffixes for images so that the right image can loaded according to platform
		imageSuffix =
        {
			["-x15"] = 1.5,		-- A good scale for Droid, Nexus One, etc.
			["-x2"] = 2,		-- A good scale for iPhone 4 and iPad
        }
	
	},
}
-- For more, see http://developer.anscamobile.com/content/configuring-projects