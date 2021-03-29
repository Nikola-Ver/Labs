import { useState } from "react";

export const usePopover = ({ onOpen, onClose } = {}) => {
  const [anchor, setAnchor] = useState(null);

  const handleOpen = (event) => {
    setAnchor(event.currentTarget);
    if (typeof onOpen === "function") {
      onOpen(event);
    }
  };

  const handleClose = (event) => {
    setAnchor(null);
    if (typeof onClose === "function") {
      onClose(event);
    }
  };

  return [anchor, handleOpen, handleClose];
};
