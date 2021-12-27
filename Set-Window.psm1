Function Set-Window {
  param (
      [parameter(ValueFromPipelineByPropertyName=$True)]
      $Handle,
      [int]$X,
      [int]$Y,
      [int]$Width,
      [int]$Height
  )
  begin {
      try {
        [void][Window]
      } catch {
        Add-Type @'
            using System;
            using System.Runtime.InteropServices;
            public class Window {
                [DllImport("user32.dll")]
                [return: MarshalAs(UnmanagedType.Bool)]
                public static extern bool GetWindowRect(IntPtr hWnd, out WindowRECT lpRect);
                [DllImport("User32.dll")]
                public extern static bool MoveWindow(IntPtr handle, int x, int y, int width, int height, bool redraw);
            }

            public struct WindowRECT {
                public int Left;        // x position of upper-left corner
                public int Top;         // y position of upper-left corner
                public int Right;       // x position of lower-right corner
                public int Bottom;      // y position of lower-right corner
            }
'@
      }
  }
  process {
      $Rectangle = New-Object WindowRECT
      $rectReturn = [Window]::GetWindowRect($Handle, [ref]$Rectangle)
      if (!$PSBoundParameters.ContainsKey('Width')) {
        $Width = $Rectangle.Right - $Rectangle.Left
      }
      if (!$PSBoundParameters.ContainsKey('Height')) {
        $Height = $Rectangle.Bottom - $Rectangle.Top
      }
      if ($rectReturn) {
        [void][Window]::MoveWindow($Handle, $X, $Y, $Width, $Height, $true)
      }
  }
}