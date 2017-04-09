//=========================================================================
// GameVision � SDK, Tools and Tutorials
// Copyright � 1994-2003 Jarrod Davis Software
// All Rights Reserved.
//-------------------------------------------------------------------------
// You are hereby granted the right to use GameVision and it's
// tools to produce your own applications without paying us any
// money, subject to the following restrictions:
//
// 1. You may not reverse engineer, or claim GameVision or it's tools
//    and tutorials as your own work.
//
// 2. We require that you acknowledge us in your application's credits
//    and/or documentation. An acceptable statement can be such as:
//
//    Created with the GameVision SDK developed by
//      Jarrod Davis Software.
//      http://www.jarroddavis.com
//
// 3. You may not create a library that uses this library as a main part
//    of the program and sell that library.
//
// 4. You may redistribute GameVision, provided that the archive remain
//    intact. All files of the original distribution must be present!
//
// 5. Media used in the demos, tutorials and tools are copyright
//    Jarrod Davis Software and may not be used for any purpose.
//
// 6. This notice may not be removed or altered from any distribution.
//
// This software is provided 'as-is', without any express or implied
// warranty. In no event will the authors be held liable for any damages
// arising from the use of this software.
//
// If you have further legal questions, please mail legal@jarroddavis.com
//-------------------------------------------------------------------------
// Website: http://www.jarroddavis.com          - Jarrod Davis Software
//          http://www.gamevisionsdk.com        - GameVision SDK
// Email  : support@jarroddavis.com             - Support
//          jarroddavis@jarroddavis.com         - General
//=========================================================================

// GVShareMem must be the first unit in your projects uses statement. GV now
// uses a shared memory manager which means memory can be shared between
// the GV DLL and the host application. If GVShareMem is not first, then an
// exception error will occur.

program gvsdk_demo;

uses
  GVShareMem, GVDLL,
  Windows,
  SysUtils,
  Forms,
  common in '..\..\common\common.pas';

const
  SCREEN_CAPTION = 'Entity'; //@@ screen caption

var
  Sprite    : Integer = -1;   //@@ sprite handle
  BossSprite: TGVSpriteImage; //@@ boss sprite image
  BossEntity: Integer = -1;   //@@ boss entity


//@@ Parameters:
//     None
//   Returns:
//     None
//   Description:
//     Save demo configuration
procedure Demo_SaveCfg;
begin
  // save cfg info
  GV_Ini_WriteString ('AUDIO',  'MusicPath', Music_Path);
  GV_Ini_WriteInteger('SCREEN', 'Bpp',        Screen_Bpp);
  GV_Ini_WriteBool   ('SCREEN', 'Windowed',   Screen_Windowed);
  GV_Ini_Flush;
end;

//@@ Parameters:
//     None
//   Returns:
//     None
//   Description:
//     Load demo configuration
procedure Demo_LoadCfg;
begin
  // check if ini exist by seeing of a value exist
  if not GV_Ini_ValueExists('SCREEN', 'Bpp') then
  begin
    Demo_SaveCfg;
  end;

  // load cfg info
  Music_Path      := GV_Ini_ReadString ('AUDIO',  'MusicPath', '');
  Screen_Bpp      := GV_Ini_ReadInteger('SCREEN', 'Bpp',       16);
  Screen_Windowed := GV_Ini_ReadBool   ('SCREEN', 'Windowed',  True);
end;

//@@ Parameters:
//     None
//   Returns:
//     None
//   Description:
//     Initialize demo
procedure Demo_Init;
begin
  // call preinit first thing
  if not Demo_PreInit(SCREEN_CAPTION) then
  begin
    MessageBox(0, 'Fatal Error', 'Failed to pre-init demo', MB_OK);
    Halt;
  end;

  // Load configuration
  Demo_LoadCfg;

  // Open a standard ZIP rezfile. You can use any of the zip managers
  // such as WinZip to manage your zip archives.
  RezFile := GV_RezFile_OpenArchive(REZFILE_PATH);

  // Set application icon. Since we are now using a rezfile, lets
  // grab the icon from it now. Just pass in the handle to rezfile.
  GV_App_SetIcon(RezFile, 'media/icons/mainicon.ico');

  // Create a fully qualified application window.
  // window attributes are:
  //  - client area set to specified width and height
  //  - single border, non-resizable, viewable on taskbar
  //  - system menu, minimize and restore
  GV_AppWindow_Open(SCREEN_CAPTION, SCREEN_WIDTH, SCREEN_HEIGHT);

  // Make application window visible.
  GV_AppWindow_Show;

  // Initalize graphics mode. _SetMode allows you to use any valid windows
  // handle so that if you need to render to a VCL based form you can. This
  // is good for making tools where you can pass the handle to your view panel
  // for example. In this case we will use the handle from our appwindow.
  // At startup GameVision as already enumrated your display modes so _SetMode
  // will attemp to find a mode that matches the params you have specified or
  // will find the closes match, else will generate an exception.
  // Bpp and refresh should be valid DirectX values.
  // Bpp should be 16 or 32.
  GV_RenderDevice_SetMode(
    GV_AppWindow_GetHandle, // window handle
    SCREEN_WIDTH,           // screen width
    SCREEN_HEIGHT,          // screen height
    SCREEN_BPP,             // screen bits per pixel
    Screen_Windowed,        // screen windowed flag
    GV_SwapEffect_Discard); // swap effect

  // Load rendered texture mapped fonts. GV fonts are made up of
  // a 256x256 texture that has the fonts characters and a .GVF file
  // that containes the rect data. When specifying a font name, be
  // sure the use the basename such as 'font0' rather than font0.png.
  Font[0] := GV_Font_Load(RezFile, 'media/fonts/font0');

  // Create Sprite interface
  Sprite := GV_Sprite_Create;

  // Define Boss Sprite. Since the boss sprite is made up of 3 images
  // laid out on aingle texture with each image being 128x128, we will use
  // the _AddImageGride to define this sprite.
  BossSprite.Handle := Sprite; // cache sprite handle
  BossSprite.Page   := GV_Sprite_LoadPage(Sprite, RezFile, GV_ColorKey, 'media/sprites/boss1.png'); // add a page
  BossSprite.Group  := GV_Sprite_AddGroup(BossSprite.Handle); // define a group for this sprite

  // add each image on grid
  GV_Sprite_AddImageGrid(BossSprite.Handle, BossSprite.Page, BossSprite.Group, 0, 0, 128, 128);
  GV_Sprite_AddImageGrid(BossSprite.Handle, BossSprite.Page, BossSprite.Group, 1, 0, 128, 128);
  GV_Sprite_AddImageGrid(BossSprite.Handle, BossSprite.Page, BossSprite.Group, 0, 1, 128, 128);

  // Create an entity object. An entity is a self contained object that can
  // exist in the game world. It is visible, has position, size and is
  // interactive.
  BossEntity := GV_Entity_Create(BossSprite.Handle, BossSprite.Page, BossSprite.Group);
  GV_Entity_SetPos(BossEntity, 320, 240);
  GV_Entity_SetFrameDelay(BossEntity, 3);

  // Initialize keyboard and mouse input. Input_Open will handle both windowed
  // and fullscreen input operations and set the input devices for exclusive
  // or non-exclusive as needed.
  GV_Input_Open(
    GV_AppWindow_GetHandle, // window handle - use the handle from app window
    SCREEN_WINDOWED);       // windowed flag (true for window, false for fullscreen)
end;

//@@ Parameters:
//     None
//   Returns:
//     None
//   Description:
//     Shutdown demo
procedure Demo_Done;
begin
  // Shutdown input. This routine will be called automatically when
  // app is terminated, but good to call manually in your app.
  GV_Input_Close;

  // Free entity
  GV_Entity_Dispose(BossEntity);

  // Free Sprite
  GV_Sprite_Dispose(Sprite);

  // Free fonts
  GV_Font_Dispose(Font[0]);

  // Restore previouse desktop resolution
  GV_RenderDevice_RestoreMode;

  // Close application window
  GV_AppWindow_Close;

  // Close rezfile
  GV_RezFile_CloseArchive(RezFile);

  // Save configuration
  Demo_SaveCfg;

  // Call postdone last thing
  Demo_PostDone;
end;

//@@ Parameters:
//     None
//   Returns:
//     None
//   Description:
//     Run demo
procedure Demo_Run;
begin
  repeat
    // Let windows update messages and run background tasks. Use this
    // function if your not using a VCL form based application.
    GV_App_ProcessMessages;

    // Check if display window and/or render device is ready. If not
    // continue to process windows messages.
    if not GV_RenderDevice_IsReady then continue;

    // Clear the current viewport area. Here we clear both the Frame
    // buffer and ZBuffer.
    GV_RenderDevice_ClearFrame(GV_ClearFrame_Default, GV_Black);

    // Tell GV to start accepting polygon data
    if GV_RenderDevice_StartFrame then
    begin
      // Display the frame rate in frames-per-second.
      GV_Font_Print(Font[0], 0, 0,  GV_Green, '%d fps', [GV_Timer_FrameRate]);
      GV_Font_Print(Font[0], 0, 12, GV_Green, 'ESC - Quit', []);

      // eneity
      GV_Entity_Render(BossEntity);

      // Display footer
      GV_Font_Center(Font[0], SCREEN_HEIGHT-26, GV_Green, 'GameVision SDK (tm)  Copyright (c) 1994-2003 Jarrod Davis Software', []);
      GV_Font_Center(Font[0], SCREEN_HEIGHT-14, GV_Green, 'Visit the GameVision webite site at: www.gamevisionsdk.com', []);

      // Tell GV to stop accepting polygon data
      GV_RenderDevice_EndFrame;
    end;

    // Make current frame buffer visible
    GV_RenderDevice_ShowFrame;

    // Calculate the elapsed time since last frame and the current
    // framerate
    GV_Timer_Update;

    // Input_Update must be called at least once per frame to gather
    // input data from the keyboard and mouse devices.
    GV_Input_Update;

    // entity
    GV_Entity_NextFrame(BossEntity, True, GV_Timer_ElapsedTime);

    // here we will check if the Escape key was hit.
    if GV_Input_KeyHit(GV_KEY_ESCAPE) then
    begin
      // the proper way to shut down a GV app is to call App_Terminate.
      // This will allow the current frame to finish processing and
      // afterwards it will then terminate by falling out of the gameloop.
      GV_App_Terminate;
    end;

    // loop until application has terminated either by closing an
    // AppWindow or calling GV_App_Terminate.
  until GV_App_IsTerminated;
end;

begin { --- program start ---- }
  // GV takes advantage of exception handling and this is the
  // most basic exception handling block for a GV application.
  try
    Demo_Init; // init
    try
      Demo_Run;  // run
    finally
      Demo_Done; // done
    end;
  except
  end;
end.
