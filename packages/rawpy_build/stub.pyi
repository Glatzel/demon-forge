from collections import namedtuple
from enum import Enum

import numpy as np # type: ignore

ImageSizes = namedtuple(
    "ImageSizes",
    [
        "raw_height",
        "raw_width",
        "height",
        "width",
        "top_margin",
        "left_margin",
        "iheight",
        "iwidth",
        "pixel_aspect",
        "flip",
        "crop_left_margin",
        "crop_top_margin",
        "crop_width",
        "crop_height",
    ],
)

class RawType(Enum):
    """
    RAW image type.
    """

    Flat = 0
    """ Bayer type or black and white """

    Stack = 1
    """ Foveon type or sRAW/mRAW files or RawSpeed decoding """

# LibRaw_thumbnail_formats
class ThumbFormat(Enum):
    """
    Thumbnail/preview image type.
    """

    JPEG = 1
    """ JPEG image as bytes object. """

    BITMAP = 2
    """ RGB image as ndarray object. """

Thumbnail = namedtuple("Thumbnail", ["format", "data"])

class LibRawError(Exception):
    pass

class LibRawFatalError(LibRawError):
    pass

class LibRawNonFatalError(LibRawError):
    pass

class LibRawUnspecifiedError(LibRawNonFatalError):
    pass

class LibRawFileUnsupportedError(LibRawNonFatalError):
    pass

class LibRawRequestForNonexistentImageError(LibRawNonFatalError):
    pass

class LibRawOutOfOrderCallError(LibRawNonFatalError):
    pass

class LibRawNoThumbnailError(LibRawNonFatalError):
    pass

class LibRawUnsupportedThumbnailError(LibRawNonFatalError):
    pass

class LibRawInputClosedError(LibRawNonFatalError):
    pass

class LibRawNotImplementedError(LibRawNonFatalError):
    pass

class LibRawUnsufficientMemoryError(LibRawFatalError):
    pass

class LibRawDataError(LibRawFatalError):
    pass

class LibRawIOError(LibRawFatalError):
    pass

class LibRawCancelledByCallbackError(LibRawFatalError):
    pass

class LibRawBadCropError(LibRawFatalError):
    pass

class LibRawTooBigError(LibRawFatalError):
    pass

class LibRawMemPoolOverflowError(LibRawFatalError):
    pass

class RawPy:
    """
    Load RAW images, work on their data, and create a postprocessed (demosaiced) image.

    All operations are implemented using numpy arrays.
    """

    def close(self):
        """
        Release all resources and close the RAW image.

        Consider using context managers for the same effect:

        .. code-block:: python

            with rawpy.imread('image.nef') as raw:
              # work with raw object

        """

    def open_file(self, path):
        """
        Opens the given RAW image file. Should be followed by a call to :meth:`~rawpy.RawPy.unpack`.

        .. NOTE:: This is a low-level method, consider using :func:`rawpy.imread` instead.

        :param str path: The path to the RAW image.
        """
    def open_buffer(self, fileobj):
        """
        Opens the given RAW image file-like object. Should be followed by a call to :meth:`~rawpy.RawPy.unpack`.

        .. NOTE:: This is a low-level method, consider using :func:`rawpy.imread` instead.

        :param file fileobj: The file-like object.
        """
    def unpack(self):
        """
        Unpacks/decodes the opened RAW image.

        .. NOTE:: This is a low-level method, consider using :func:`rawpy.imread` instead.
        """
    def unpack_thumb(self):
        """
        Unpacks/decodes the thumbnail/preview image, whichever is bigger.

        .. NOTE:: This is a low-level method, consider using :meth:`~rawpy.RawPy.extract_thumb` instead.
        """
    @property
    def raw_type(self) -> RawType:
        """
        Return the RAW type.

        :rtype: :class:`rawpy.RawType`
        """
    @property
    def raw_image(self) -> np.ndarray:
        """
        View of RAW image. Includes margin.

        For Bayer images, a 2D ndarray is returned.
        For Foveon and other RGB-type images, a 3D ndarray is returned.
        Note that there may be 4 color channels, where the 4th channel can be blank (zeros).

        Modifying the returned array directly influences the result of
        calling :meth:`~rawpy.RawPy.postprocess`.

        .. WARNING:: The returned numpy array can only be accessed while this RawPy instance
            is not closed yet, that is, within a :code:`with` block or before calling :meth:`~rawpy.RawPy.close`.
            If you need to work on the array after closing the RawPy instance,
            make sure to create a copy of it with :code:`raw_image = raw.raw_image.copy()`.

        :rtype: ndarray of shape (h,w[,c])
        """
    @property
    def raw_image_visible(self):
        """
        Like raw_image but without margin.

        :rtype: ndarray of shape (hv,wv[,c])
        """
    def raw_value(self, row: int, column: int) -> int:
        """
        Return RAW value at given position relative to the full RAW image.
        Only usable for flat RAW images (see :attr:`~rawpy.RawPy.raw_type` property).
        """
    def raw_value_visible(self, row: int, column: int) -> int:
        """
        Return RAW value at given position relative to visible area of image.
        Only usable for flat RAW images (see :attr:`~rawpy.RawPy.raw_type` property).
        """
    @property
    def sizes(self) -> ImageSizes:
        """
        Return a :class:`rawpy.ImageSizes` instance with size information of
        the RAW image and postprocessed image.
        """
    @property
    def num_colors(self):
        """
        Number of colors.
        Note that e.g. for RGBG this can be 3 or 4, depending on the camera model,
        as some use two different greens.
        """
    @property
    def color_desc(self):
        """
        String description of colors numbered from 0 to 3 (RGBG,RGBE,GMCY, or GBTG).
        Note that same letters may not refer strictly to the same color.
        There are cameras with two different greens for example.
        """
    def raw_color(self, row: int, column: int) -> int:
        """
        Return color index for the given coordinates relative to the full RAW size.
        Only usable for flat RAW images (see raw_type property).
        """
    @property
    def raw_colors(self):
        """
        An array of color indices for each pixel in the RAW image.
        Equivalent to calling raw_color(y,x) for each pixel.
        Only usable for flat RAW images (see raw_type property).

        :rtype: ndarray of shape (h,w)
        """
    @property
    def raw_colors_visible(self):
        """
        Like raw_colors but without margin.

        :rtype: ndarray of shape (hv,wv)
        """
    @property
    def raw_pattern(self):
        """
        The smallest possible Bayer pattern of this image.

        :rtype: ndarray, or None if not a flat RAW image
        """
    @property
    def camera_whitebalance(self):
        """
        White balance coefficients (as shot). Either read from file or calculated.

        :rtype: list of length 4
        """
    @property
    def daylight_whitebalance(self):
        """
        White balance coefficients for daylight (daylight balance).
        Either read from file, or calculated on the basis of file data,
        or taken from hardcoded constants.

        :rtype: list of length 4
        """
    @property
    def black_level_per_channel(self):
        """
        Per-channel black level correction.

        :rtype: list of length 4
        """
    @property
    def white_level(self):
        """
        Level at which the raw pixel value is considered to be saturated.
        """
    @property
    def camera_white_level_per_channel(self):
        """
        Per-channel saturation levels read from raw file metadata, if it exists. Otherwise None.

        :rtype: list of length 4, or None if metadata missing
        """
    @property
    def color_matrix(self):
        """
        Color matrix, read from file for some cameras, calculated for others.

        :rtype: ndarray of shape (3,4)
        """
    @property
    def rgb_xyz_matrix(self):
        """
        Camera RGB - XYZ conversion matrix.
        This matrix is constant (different for different models).
        Last row is zero for RGB cameras and non-zero for different color models (CMYG and so on).

        :rtype: ndarray of shape (4,3)
        """
    @property
    def tone_curve(self):
        """
        Camera tone curve, read from file for Nikon, Sony and some other cameras.

        :rtype: ndarray of length 65536
        """
    def dcraw_process(self, params=None, **kw):
        """
        Postprocess the currently loaded RAW image.

        .. NOTE:: This is a low-level method, consider using :meth:`~rawpy.RawPy.postprocess` instead.

        :param rawpy.Params params:
            The parameters to use for postprocessing.
        :param **kw:
            Alternative way to provide postprocessing parameters.
            The keywords are used to construct a :class:`rawpy.Params` instance.
            If keywords are given, then `params` must be omitted.
        """
    def dcraw_make_mem_image(self):
        """
        Return the postprocessed image (see :meth:`~rawpy.RawPy.dcraw_process`) as numpy array.

        .. NOTE:: This is a low-level method, consider using :meth:`~rawpy.RawPy.postprocess` instead.

        :rtype: ndarray of shape (h,w,c)
        """
    def dcraw_make_mem_thumb(self):
        """
        Return the thumbnail/preview image (see :meth:`~rawpy.RawPy.unpack_thumb`)
        as :class:`rawpy.Thumbnail` object.
        For JPEG thumbnails, data is a bytes object and can be written as-is to file.
        For bitmap thumbnails, data is an ndarray of shape (h,w,c).
        If no image exists or the format is unsupported, an exception is raised.

        .. NOTE:: This is a low-level method, consider using :meth:`~rawpy.RawPy.extract_thumb` instead.

        :rtype: :class:`rawpy.Thumbnail`
        """
    def extract_thumb(self):
        """
        Extracts and returns the thumbnail/preview image (whichever is bigger)
        of the opened RAW image as :class:`rawpy.Thumbnail` object.
        For JPEG thumbnails, data is a bytes object and can be written as-is to file.
        For bitmap thumbnails, data is an ndarray of shape (h,w,c).
        If no image exists or the format is unsupported, an exception is raised.

        .. code-block:: python
            import imageio.v3 as iio

            ...

            with rawpy.imread('image.nef') as raw:
              try:
                thumb = raw.extract_thumb()
              except rawpy.LibRawNoThumbnailError:
                print('no thumbnail found')
              except rawpy.LibRawUnsupportedThumbnailError:
                print('unsupported thumbnail')
              else:
                if thumb.format == rawpy.ThumbFormat.JPEG:
                  with open('thumb.jpg', 'wb') as f:
                    f.write(thumb.data)
                elif thumb.format == rawpy.ThumbFormat.BITMAP:
                  iio.imwrite('thumb.tiff', thumb.data)

        :rtype: :class:`rawpy.Thumbnail`
        """
    def postprocess(self, params=None, **kw):
        """
        Postprocess the currently loaded RAW image and return the
        new resulting image as numpy array.

        :param rawpy.Params params:
            The parameters to use for postprocessing.
        :param **kw:
            Alternative way to provide postprocessing parameters.
            The keywords are used to construct a :class:`rawpy.Params` instance.
            If keywords are given, then `params` must be omitted.
        :rtype: ndarray of shape (h,w,c)
        """
    def handle_error(self, code: int): ...

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
