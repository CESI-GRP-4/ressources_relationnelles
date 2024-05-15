// Import React and its hooks
import React, { createContext, useContext, useState, ReactNode } from 'react';

// Define an interface for the context values
interface CommentContextType {
       idParent: number | undefined;
       replyingTo: string;
       handleSetReply: (id: number, name: string) => void;
       resetReply: () => void;
}

// Provide a default value matching the interface
const defaultContextValue: CommentContextType = {
       idParent: undefined,
       replyingTo: '',
       handleSetReply: () => { },  // These do nothing by default
       resetReply: () => { }
};

// Create the context with the default value
const CommentContext = createContext < CommentContextType > (defaultContextValue);

// Hook to use the context
export const useCommentContext = () => useContext(CommentContext);

// Define props for the CommentProvider component
interface CommentProviderProps {
       children: ReactNode;
}

// Define the CommentProvider component with typed props
export const CommentProvider: React.FC<CommentProviderProps> = ({ children }) => {
       const [idParent, setIdParent] = useState < number | undefined > (undefined);
       const [replyingTo, setReplyingTo] = useState < string > ('');

       const handleSetReply = (id: number, name: string) => {
              setIdParent(id);
              setReplyingTo(name);
       };

       const resetReply = () => {
              setIdParent(undefined);
              setReplyingTo('');
       };

       return (
              <CommentContext.Provider value={{ idParent, replyingTo, handleSetReply, resetReply }}>
                     {children}
              </CommentContext.Provider>
       );
};
