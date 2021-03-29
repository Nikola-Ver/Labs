import { useState } from "react";

export const UseDialog = ({ onOpen, onClose, startState } = {}) => {
  const [dialog, setDialog] = useState(startState || false);

  const closeDialog = (event) => {
    setDialog(false);
    if (onClose && typeof onClose === "function") {
      onClose(event);
    }
  };

  const openDialog = (event) => {
    setDialog(true);
    if (typeof onOpen === "function") {
      onOpen(event);
    }
  };

  return [dialog, closeDialog, openDialog];
};
