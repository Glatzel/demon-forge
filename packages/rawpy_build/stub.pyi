from enum import Enum

class DemosaicAlgorithm(int, Enum):
    """Identifiers for demosaic algorithms."""

    LINEAR = 0
    VNG = 1
    PPG = 2
    AHD = 3
    DCB = 4
    # comment GPL algorithm
    # 5-9 only usable if demosaic pack GPL2 available
    # MODIFIED_AHD = 5
    # AFD = 6
    # VCD = 7
    # VCD_MODIFIED_AHD = 8
    # LMMSE = 9
    # 10 only usable if demosaic pack GPL3 available
    # AMAZE = 10
    # 11-12 only usable for LibRaw >= 0.16
    DHT = 11
    AAHD = 12
    @property
    def isSupported(self):
        """
        Return True if the demosaic algorithm is supported, False if it is not,
        and None if the support status is unknown. The latter is returned if
        LibRaw < 0.15.4 is used or if it was compiled without cmake.

        The necessary information is read from the libraw_config.h header which
        is only written with cmake builds >= 0.15.4.
        """
    def checkSupported(self):
        """
        Like :attr:`isSupported` but raises an exception for the `False` case.
        """

class FBDDNoiseReductionMode(Enum):
    """
    FBDD noise reduction modes.
    """

    Off = 0
    Light = 1
    Full = 2

class ColorSpace(Enum):
    """
    Color spaces.
    """

    raw = 0
    sRGB = 1
    Adobe = 2
    Wide = 3
    ProPhoto = 4
    XYZ = 5
    ACES = 6
    P3D65 = 7
    Rec2020 = 8

class HighlightMode(Enum):
    """
    Highlight modes.
    """

    Clip = 0
    Ignore = 1
    Blend = 2
    ReconstructDefault = 5

    @classmethod
    def Reconstruct(cls, level):
        """
        :param int level: 3 to 9, low numbers favor whites, high numbers favor colors
        """

class Params:
    """
    A class that handles postprocessing parameters.
    """
    def __init__(
        self,
        demosaic_algorithm=None,
        half_size=False,
        four_color_rgb=False,
        dcb_iterations=0,
        dcb_enhance=False,
        fbdd_noise_reduction=FBDDNoiseReductionMode.Off,
        noise_thr=None,
        median_filter_passes=0,
        use_camera_wb=False,
        use_auto_wb=False,
        user_wb=None,
        output_color=ColorSpace.sRGB,
        output_bps=8,
        user_flip=None,
        user_black=None,
        user_sat=None,
        no_auto_bright=False,
        auto_bright_thr=None,
        adjust_maximum_thr=0.75,
        bright=1.0,
        highlight_mode=HighlightMode.Clip,
        exp_shift=None,
        exp_preserve_highlights=0.0,
        no_auto_scale=False,
        gamma=None,
        chromatic_aberration=None,
        bad_pixels_path=None,
    ):
        """

        If use_camera_wb and use_auto_wb are False and user_wb is None, then
        daylight white balance correction is used.
        If both use_camera_wb and use_auto_wb are True, then use_auto_wb has priority.

        :param rawpy.DemosaicAlgorithm demosaic_algorithm: default is AHD
        :param bool half_size: outputs image in half size by reducing each 2x2 block to one pixel
                               instead of interpolating
        :param bool four_color_rgb: whether to use separate interpolations for two green channels
        :param int dcb_iterations: number of DCB correction passes, requires DCB demosaicing algorithm
        :param bool dcb_enhance: DCB interpolation with enhanced interpolated colors
        :param rawpy.FBDDNoiseReductionMode fbdd_noise_reduction: controls FBDD noise reduction before demosaicing
        :param float noise_thr: threshold for wavelet denoising (default disabled)
        :param int median_filter_passes: number of median filter passes after demosaicing to reduce color artifacts
        :param bool use_camera_wb: whether to use the as-shot white balance values
        :param bool use_auto_wb: whether to try automatically calculating the white balance
        :param list user_wb: list of length 4 with white balance multipliers for each color
        :param rawpy.ColorSpace output_color: output color space
        :param int output_bps: 8 or 16
        :param int user_flip: 0=none, 3=180, 5=90CCW, 6=90CW,
                              default is to use image orientation from the RAW image if available
        :param int user_black: custom black level
        :param int user_sat: saturation adjustment (custom white level)
        :param bool no_auto_scale: Whether to disable pixel value scaling
        :param bool no_auto_bright: whether to disable automatic increase of brightness
        :param float auto_bright_thr: ratio of clipped pixels when automatic brighness increase is used
                                      (see `no_auto_bright`). Default is 0.01 (1%).
        :param float adjust_maximum_thr: see libraw docs
        :param float bright: brightness scaling
        :param highlight_mode: highlight mode
        :type highlight_mode: :class:`rawpy.HighlightMode` | int
        :param float exp_shift: exposure shift in linear scale.
                          Usable range from 0.25 (2-stop darken) to 8.0 (3-stop lighter).
        :param float exp_preserve_highlights: preserve highlights when lightening the image with `exp_shift`.
                          From 0.0 to 1.0 (full preservation).
        :param tuple gamma: pair (power,slope), default is (2.222, 4.5) for rec. BT.709
        :param tuple chromatic_aberration: pair (red_scale, blue_scale), default is (1,1),
                                           corrects chromatic aberration by scaling the red and blue channels
        :param str bad_pixels_path: path to dcraw bad pixels file. Each bad pixel will be corrected using
                                    the mean of the neighbor pixels. See the :mod:`rawpy.enhance` module
                                    for alternative repair algorithms, e.g. using the median.
        """
